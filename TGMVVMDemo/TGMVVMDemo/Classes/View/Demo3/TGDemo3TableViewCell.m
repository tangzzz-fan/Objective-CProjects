//
//  TGDemo3TableViewCell.m
//  TGMVVMDemo
//
//  Created by 汤振治 on 22/01/2018.
//  Copyright © 2018 Centaline. All rights reserved.
//

#import "TGDemo3TableViewCell.h"

#import <ReactiveCocoa.h>
#import "TGDemo3CellViewModel.h"

@interface TGDemo3TableViewCell()
@property (weak, nonatomic) IBOutlet UIView *containerView;
/** tempArrau */
@property (nonatomic, strong) NSArray *tempArray;
@end
@implementation TGDemo3TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self createUI];
}

- (void)createUI {
    
    
    if (self.tempArray.count) {
        [self.containerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        for (NSInteger i = 0; i < self.tempArray.count; i ++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(3 + i * 30, 8, 50, 40)];
            label.text = self.tempArray[i];
            label.backgroundColor = [UIColor purpleColor];
            [self.containerView addSubview:label];
        }
    }
}

- (void)bindViewModel:(TGDemo3CellViewModel *)viewModel {
    RAC(self, tempArray) = [[RACSignal return:viewModel.dataSource] distinctUntilChanged];
    [RACObserve(self, tempArray) subscribeNext:^(id x) {
        [self createUI];
    }];
}

@end
