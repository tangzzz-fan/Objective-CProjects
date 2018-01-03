//
//  TGTest3TableViewCell.m
//  TGMVVMDemo
//
//  Created by MacPro on 2018/1/2.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import "TGTest3TableViewCell.h"
#import "TGTest3ViewModel.h"
#import "TGBaseModel.h"

@implementation TGTest3TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)bindViewModel:(id)viewModel withParams:(NSDictionary *)params {
    TGTest3ViewModel *test1VM = (TGTest3ViewModel *)viewModel;
//    NSIndexPath *indexPath = params[@"DataIndexPath"];
    NSInteger indexpathRow = [params[@"DataIndexPath"] integerValue];

//    NSInteger indexpathRow = indexPath.row;
    TGBaseModel *model = test1VM.modelArray[indexpathRow];
    self.TestLabel.text = model.description;
}

@end
