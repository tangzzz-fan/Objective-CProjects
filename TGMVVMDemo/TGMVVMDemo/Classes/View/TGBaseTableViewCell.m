//
//  TGBaseTableViewCell.m
//  TGMVVMDemo
//
//  Created by MacPro on 2018/1/2.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import "TGBaseTableViewCell.h"

@class TGBaseCellViewModel;

@implementation TGBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)bindViewModel:(__kindof TGBaseCellViewModel *)viewModel withParams:(NSDictionary *)params {

}
@end
