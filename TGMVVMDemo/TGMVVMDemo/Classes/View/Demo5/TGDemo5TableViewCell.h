//
//  TGDemo5TableViewCell.h
//  TGMVVMDemo
//
//  Created by MacPro on 2018/1/24.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TGDemo5CellViewModel;

@interface TGDemo5TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *testLabel;
- (void)bindWithViewModel:(TGDemo5CellViewModel *)viewModel;
@end
