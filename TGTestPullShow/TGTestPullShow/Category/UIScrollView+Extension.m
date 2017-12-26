//
//  UIScrollView+Extension.m
//  TGTestPullShow
//
//  Created by MacPro on 2017/12/26.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "UIScrollView+Extension.h"
#import <objc/runtime.h>

static char *kAssociatedObjectKey = "pro";

@implementation UIScrollView (Extension)
- (BOOL)showPullPromotionView {
    return self.pullPromotionView.isHidden;
}

- (void)setShowPullPromotionView:(BOOL)showPullPromotionView {
    self.pullPromotionView.hidden = !showPullPromotionView;
    if (![self.pullPromotionView isObserving]) {
        [self addObserver:self.pullPromotionView forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    } else if ([self.pullPromotionView isObserving]) {
        [self removeObserver:self.pullPromotionView forKeyPath:@"contentOffset"];
    }
}

- (PullPromotionView *)pullPromotionView {
    
    PullPromotionView *view = objc_getAssociatedObject(self, kAssociatedObjectKey);
    if (view == nil) {
        [self createPullPromotionView];
    }
    return view;
}

- (void)setPullPromotionView:(PullPromotionView *)pullPromotionView {
    [self willChangeValueForKey:@"contentOffset"];
    objc_setAssociatedObject(self, kAssociatedObjectKey, pullPromotionView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"contentOffset"];
}

- (void)createPullPromotionView {
    PullPromotionView *view = [[PullPromotionView alloc] init];
    view.isObserving = NO;
    [self addSubview:view];
    view.scrollView = self;
    view.layer.zPosition = 1;
    self.pullPromotionView = view;
}
@end
