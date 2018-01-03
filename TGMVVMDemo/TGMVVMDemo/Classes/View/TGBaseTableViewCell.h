//
//  TGBaseTableViewCell.h
//  TGMVVMDemo
//
//  Created by MacPro on 2018/1/2.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TGBaseViewModel.h"

@interface TGBaseTableViewCell : UITableViewCell

- (void)bindViewModel:(id)viewModel withParams:(NSDictionary *)params;
@end
