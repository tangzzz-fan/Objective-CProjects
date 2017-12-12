//
//  TGTagButton.m
//  TGTestResponder
//
//  Created by MacPro on 2017/12/12.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "TGTagButton.h"

@implementation TGTagButton

/** 只点击圆形区域内的按钮 */
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {

    CGFloat halfWidth = self.bounds.size.width / 2;

    CGFloat xDistance = point.x - halfWidth;

    CGFloat yDistance = point.y - halfWidth;

    CGFloat radius = sqrt(xDistance * xDistance + yDistance * yDistance);

    NSLog(@"HaldWidth:%f---point:%@---x轴距离:%f---y轴距离:%f--半径:%f",halfWidth,NSStringFromCGPoint(point),xDistance,yDistance,radius);

    return radius <= halfWidth;

}

@end
