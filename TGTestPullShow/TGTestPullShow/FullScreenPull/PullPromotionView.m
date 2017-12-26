//
//  PullPromotionView.m
//  TGTestPullShow
//
//  Created by MacPro on 2017/12/26.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "PullPromotionView.h"

#import "UIView+ZFCategory.h"

@implementation PullPromotionView

#define RefreshTriggerHeight 70
#define PromotionTriggerHeight 100

#pragma mark - AnimationFunction
- (instancetype)init {
    if (self = [super init]) {
        CGRect rect = [UIScreen mainScreen].bounds;
        rect.origin.y = -rect.size.height;
        [self setFrame:rect];
        self.isObserving = NO;
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.state = stopped;
    // 加载图片
    [self loadImageView];
    // 增加 hud
}

- (void)loadImageView {
    UIImageView *backgroundImg = [[UIImageView alloc] initWithFrame:self.bounds];
    backgroundImg.image = [UIImage imageNamed:@"background"];
    UIImageView *forgroundImg = [[UIImageView alloc] initWithFrame:self.bounds];
    forgroundImg.image = [UIImage imageNamed:@"forground"];
    [self addSubview:backgroundImg];
    [self addSubview:forgroundImg];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {

    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint point = [change[NSKeyValueChangeNewKey] CGPointValue];
        NSLog(@"point value %@", NSStringFromCGPoint(point));
        [self scrollViewDidScrollTo:point];
    }
}

- (void)scrollViewDidScrollTo:(CGPoint)contentOffset {
    if (self.state == refreshing) {
        return;
    }
    
    CGFloat scrollOffsetRefreshHold = -RefreshTriggerHeight;
    CGFloat scrollOffsetPromotionHold = -PromotionTriggerHeight;
    
    if (![self.scrollView isDragging] && self.state == refreshTriggered) { // 触发刷新
        self.state = refreshing;
    } else if (![self.scrollView isDragging] && self.state == promotionTriggered) { // 展示全屏
        self.state = promotionShowing;
    } else if (contentOffset.y < scrollOffsetRefreshHold && contentOffset.y > scrollOffsetPromotionHold && [self.scrollView isDragging] && self.state == stopped) { // 刷新
        self.state = refreshTriggered;
    } else if (contentOffset.y < scrollOffsetPromotionHold && (self.state == stopped || self.state == refreshTriggered) && [self.scrollView isDragging]) {
        self.state = promotionTriggered;
    } else if (contentOffset.y >= scrollOffsetRefreshHold && self.state != stopped) {
        self.state = stopped;
    }
    
}

/** 分发状态 */
- (void)dispatchState:(PullPromotionState)state {
    PullPromotionState previousState = _state;
    _state = state;
    
    switch (state) {
        case refreshing:
            // 执行刷新视图
            [self setScrollViewForRefreshing];
            if (previousState == refreshTriggered) {
                if (self.refreshBlock) {
                    self.refreshBlock();
                }
            }
            break;
        case promotionShowing:
            [self setScrollViewForPromotion];
            if (self.promotionBlock) {
                self.promotionBlock();
            }
            break;
        case stopped:
            [self resetScrollView];
            break;
        
        default:
            break;
    }
}

/** 设置 scrollView 为刷新视图 */
- (void)setScrollViewForRefreshing {
    UIEdgeInsets currentInset = self.scrollView.contentInset;
    currentInset.top = RefreshTriggerHeight;
    CGPoint offset = CGPointMake(self.scrollView.contentOffset.x, -currentInset.top);
    [self animateScrollView:currentInset Offset:offset animationDuration:1];
}

/** 设置 scrollView 为全屏展示状态 */
- (void)setScrollViewForPromotion {
    UIEdgeInsets currentInset = self.scrollView.contentInset;
    currentInset.top = self.bounds.size.height;
    CGPoint offset = CGPointMake(self.scrollView.contentOffset.x, -currentInset.top);
    self.scrollView.contentInset = currentInset;
    [self.scrollView setContentOffset:offset animated:YES];
}

/** 重置 scrollView 位置状态 */
- (void)resetScrollView {
    UIEdgeInsets currentInset = self.scrollView.contentInset;
    currentInset.top = 0;
    CGPoint offset = CGPointMake(self.scrollView.contentOffset.x, -currentInset.top);
    self.scrollView.contentInset = currentInset;
    [self animateScrollView:currentInset Offset:offset animationDuration:0.2];
}

- (void)animateScrollView:(UIEdgeInsets)contentInset Offset:(CGPoint)contentOffset animationDuration:(CFTimeInterval)animationDuration {
    [UIView animateWithDuration:animationDuration delay:0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.scrollView.contentOffset = contentOffset;
        self.scrollView.contentInset = contentInset;
    } completion:nil];
}

- (void)startAnimate {
    self.state = refreshTriggered;
    self.state = refreshing;
}

- (void)stopAnimate {
    self.state = stopped;
}


#pragma mark - Setter && Getter
- (void)setState:(PullPromotionState)state {

    if (_state == state) { // 状态不同, 需要通知其他人
        return;
    }
    [self dispatchState:state];
}


@end
