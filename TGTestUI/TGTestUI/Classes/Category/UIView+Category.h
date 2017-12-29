//
//  UIView+Category.h
//  TGTestUI
//
//  Created by MacPro on 2017/12/29.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Category)
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat maxX;
@property (nonatomic, assign) CGFloat maxY;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat originX;
@property (nonatomic, assign) CGFloat originY;

/**
 *  从 xib 文件中加载文件
 */
+ (instancetype)viewFromXib;

@end
