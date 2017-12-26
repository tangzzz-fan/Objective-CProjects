//
//  PullPromotionView.h
//  TGTestPullShow
//
//  Created by MacPro on 2017/12/26.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    stopped,
    refreshTriggered,
    promotionTriggered,
    refreshing,
    promotionShowing
} PullPromotionState;

// 执行刷新操作的 block
typedef void(^RefreshBlock)(void);
// 全屏执行的 block
typedef void(^PromotionBlock)(void);

@interface PullPromotionView : UIView
@property (weak, nonatomic) UIScrollView *scrollView;
@property (copy, nonatomic) RefreshBlock refreshBlock;
@property (copy, nonatomic) PromotionBlock promotionBlock;

// 正在监听
@property (assign, nonatomic) BOOL isObserving;

// 下拉状态
@property (assign, nonatomic) PullPromotionState state;

- (void)startAnimate;

- (void)stopAnimate;
@end
