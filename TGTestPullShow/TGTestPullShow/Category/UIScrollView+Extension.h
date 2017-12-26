//
//  UIScrollView+Extension.h
//  TGTestPullShow
//
//  Created by MacPro on 2017/12/26.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullPromotionView.h"

@interface UIScrollView (Extension)
// view
@property (strong, nonatomic) PullPromotionView *pullPromotionView;
// 是否显示下拉视图
@property (assign, nonatomic) BOOL showPullPromotionView;


@end
