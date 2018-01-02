//
//  TGTest4TableViewCell.m
//  TGMVVMDemo
//
//  Created by MacPro on 2018/1/2.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import "TGTest4TableViewCell.h"
#import "TGTest4ViewModel.h"
#import "TGBaseModel.h"


@implementation TGTest4TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)bindViewModel:(id)viewModel withParams:(NSDictionary *)params {
    TGTest4ViewModel *test1VM = (TGTest4ViewModel *)viewModel;
//    NSIndexPath *indexPath = params[@"DataIndexPath"];
    NSInteger indexpathRow = [params[@"DataIndexPath"] integerValue];

    NSLog(@"params %@", params);

//    NSInteger indexpathRow = indexPath.row;
    
    TGBaseModel *model = test1VM.modelArray[indexpathRow];
    self.TestLabel.text = model.description;
}

@end
