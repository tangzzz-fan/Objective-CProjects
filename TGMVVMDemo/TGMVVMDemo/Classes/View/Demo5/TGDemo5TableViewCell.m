//
//  TGDemo5TableViewCell.m
//  TGMVVMDemo
//
//  Created by MacPro on 2018/1/24.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import "TGDemo5CellViewModel.h"
#import "TGDemo5TableViewCell.h"

@interface TGDemo5TableViewCell()
@property (strong, nonatomic) TGDemo5CellViewModel *viewModel;

@end

@implementation TGDemo5TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)bindWithViewModel:(TGDemo5CellViewModel *)viewModel {
    self.viewModel = viewModel;
    self.testLabel.text = viewModel.dict[viewModel.dict.allKeys[0]];
}

@end
