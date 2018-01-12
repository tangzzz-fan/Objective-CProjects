//
//  UIButton+TGExtension.m
//  TGTestResponder
//
//  Created by MacPro on 2017/12/12.
//  Copyright © 2017年 Centaline. All rights reserved.
//  为 UIButton 添加一个方法 实现控制热区大小

#import "UIButton+TGExtension.h"
#import <objc/runtime.h>

static const NSString *key_hit_test_edge_insets = @"HitTestEdgeInsets";

@implementation UIButton (TGExtension)
- (void)setHitTestEdgeInsets:(UIEdgeInsets)hitTestEdgeInsets {
    NSValue *value = [NSValue value:&hitTestEdgeInsets withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, &key_hit_test_edge_insets, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)hitTestEdgeInsets {
    NSValue *value = objc_getAssociatedObject(self, &key_hit_test_edge_insets);
    if (value) {
        UIEdgeInsets edgeInsets; [value getValue:&edgeInsets]; return edgeInsets;
    } else {
        return UIEdgeInsetsZero;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if(UIEdgeInsetsEqualToEdgeInsets(self.hitTestEdgeInsets, UIEdgeInsetsZero) || !self.enabled || self.hidden) {
        return [super pointInside:point withEvent:event];
    }
    
    CGRect relativeFrame = self.bounds;
    // 重新调整 UIButton 的热区
    CGRect hitFrame = UIEdgeInsetsInsetRect(relativeFrame, self.hitTestEdgeInsets);
    
    return CGRectContainsPoint(hitFrame, point);
}

@end
