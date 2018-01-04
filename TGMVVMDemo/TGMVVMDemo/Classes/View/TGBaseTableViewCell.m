//
//  TGBaseTableViewCell.m
//  TGMVVMDemo
//
//  Created by MacPro on 2018/1/2.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import "TGBaseTableViewCell.h"

#import "TGBaseViewModel.h"
#import "TGBaseCellViewModel.h"

@implementation TGBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)bindViewModel:(__kindof TGBaseCellViewModel *)viewModel {
    
}

// Demo1
- (void)bindViewModel:(__kindof TGBaseViewModel *)viewModel withParams:(NSDictionary *)params {

}
@end
