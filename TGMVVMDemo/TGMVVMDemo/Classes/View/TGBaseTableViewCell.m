//
//  TGBaseTableViewCell.m
//  TGMVVMDemo
//
//  Created by MacPro on 2018/1/2.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import "TGBaseTableViewCell.h"

@implementation TGBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    if (self.configBlock) {
        self.configBlock();
    }
}

- (void)bindViewModel:(id)viewModel withParams:(NSDictionary *)params {
//    NSLog(@"viewModel Class %@, params :%@", [viewModel class], params);
}
@end
