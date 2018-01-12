//
//  TGScenicCellViewModel.m
//  TGMVVMDemo
//
//  Created by 汤振治 on 04/01/2018.
//  Copyright © 2018 Centaline. All rights reserved.
//  为 Scenic 业务定制使用的 ViewModel

#import "TGScenicCellViewModel.h"
#import "TGScenic.h"

// View -> ViewModel -> Model

@interface TGScenicCellViewModel()
/** scnic */
@property (nonatomic, strong) TGScenic *scenic;


@end

@implementation TGScenicCellViewModel
- (instancetype)initWithScenic:(TGScenic *)scenic {
    if (self = [super init]) {
        self.cellName = @"TGPOITableViewCell";
        _scenic = scenic;
        [self bindSignals];
    }
    return self;
}

// 绑定 cellViewModel 中需要使用的信号
- (void)bindSignals {
    // 创建一个直接返回 scenic 数据的信号
    // 这里使用的 RACReturnSignal 信号, 会直接返回一个信号
    // 这里就是将数组模型作为一个信号源, 产生一个信号, 后续对这个信号的操作, 就是对这个模型数据的操作
    
    RACSignal *scenicSignal = [RACSignal return:self.scenic];
    
    // titleSignal 返回 title, 这里使用 map 从源信号中转换
    self.titleSignal = [scenicSignal map:^id(TGScenic *scenic) {
        return scenic.name;
    }];
    
    // 返回回价格信号
    
    self.priceSignal = [scenicSignal map:^id(TGScenic *scenic) {
        NSString *priceString = [NSString stringWithFormat:@"¥%.2f起", scenic.lowestPrice];
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:priceString
                                                                                            attributes:@{NSForegroundColorAttributeName : [UIColor blueColor]}];
        [attributeString setAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10],
                                         NSForegroundColorAttributeName : [UIColor blueColor]}
                                 range:NSMakeRange([priceString length] - 1, 1)];
        
        return [attributeString copy];
    }];
    
    self.campaignSignal = [scenicSignal map:^id(TGScenic *scenic) {
        return scenic.campaignTag;
    }];
    
    self.campaignHiddenSignal = [scenicSignal map:^id(TGScenic *scenic) {
        return @(scenic.campaignTag.length == 0);
    }];
    
    // 配置使用的图片数据, 并放置在后台线程中处理
    self.frontImageSignal = [[[scenicSignal map:^id(TGScenic *scenic) {
        NSData *data = [NSData dataWithContentsOfURL:scenic.frontImgURL];
        return [UIImage imageWithData:data];
    }] subscribeOn:[RACScheduler schedulerWithPriority:RACSchedulerPriorityBackground]]
                             deliverOnMainThread];
    
    // 右下角的显示取决于当前城市的数据是否正确返回
    self.rightFooterSignal = [RACSignal combineLatest:@[scenicSignal, RACObserve(self, currentCityID)] reduce:^id(TGScenic *scenic, NSNumber *currentCityID){
        if ([currentCityID integerValue] == scenic.cityID) {
            return scenic.areaName;
        } else {
            return scenic.cityName;
        }
    }];
    
}
@end
