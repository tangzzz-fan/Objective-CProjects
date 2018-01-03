//
//  TGTest2TableViewCell.m
//  TGMVVMDemo
//
//  Created by MacPro on 2018/1/2.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import "TGTest2TableViewCell.h"
#import "TGTest2ViewModel.h"
#import "TGBaseModel.h"

@implementation TGTest2TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)bindViewModel:(id)viewModel withParams:(NSDictionary *)params {
    TGTest2ViewModel *test1VM = (TGTest2ViewModel *)viewModel;
//    NSIndexPath *indexPath = params[@"DataIndexPath"];
    NSInteger indexpathRow = [params[@"DataIndexPath"] integerValue];

//    NSInteger indexpathRow = indexPath.row;
    TGBaseModel *model = test1VM.modelArray[indexpathRow];
    self.TestLabel.text = model.description;
}

@end
