//
//  TGButton.m
//  TGTestResponder
//
//  Created by MacPro on 2017/12/12.
//  Copyright © 2017年 Centaline. All rights reserved.
//  按钮点击区域太小, 要求扩大按钮的点击区域

#import "TGButton.h"

@implementation TGButton
/** 放大热区 */
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect bounds = self.bounds;
    // 若点击区域小于 44*44 就放大热区
    CGFloat widthDelta = MAX(44.0 - bounds.size.width, 0);
    CGFloat heightDelta = MAX(44.0 - bounds.size.height, 0);
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    NSLog(@"FlyElephant---被点击了:%@----点击的点:%@",NSStringFromCGRect(bounds), NSStringFromCGPoint(point));
    return CGRectContainsPoint(bounds, point);
}





@end
