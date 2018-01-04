//
//  TGBaseTableViewCell.h
//  TGMVVMDemo
//
//  Created by MacPro on 2018/1/2.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TGBaseCellViewModel;
@class TGBaseViewModel;

@interface TGBaseTableViewCell : UITableViewCell
// 使用 viewModel 绑定 cell
- (void)bindViewModel:(__kindof TGBaseCellViewModel *)viewModel;

// Demo1
- (void)bindViewModel:(__kindof TGBaseViewModel *)viewModel withParams:(NSDictionary *)params;
@end
