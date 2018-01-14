//
//  TGStyle.h
//  TGTestUI
//
//  Created by MacPro on 2017/12/28.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TGStyle : NSObject

// 是否可以滚动
@property (assign, nonatomic) BOOL isScrollAble;
@property (assign, nonatomic) BOOL isScrollToMiddle;

@property (assign, nonatomic) BOOL isShowBottomLine;
@property (assign, nonatomic) BOOL isShowCoverView;


@property (assign, nonatomic) CGFloat titleMarign;
@property (assign, nonatomic) CGFloat coverMargin;
@property (assign, nonatomic) CGFloat coverHeight;


@property (strong, nonatomic) UIFont *titleFont;

@property (strong, nonatomic) UIColor *normalColor;
@property (strong, nonatomic) UIColor *selectedColor;
// coverView backgroundColor
@property (strong, nonatomic) UIColor *coverViewBackgroundColor;
// coverView alpha
@property (assign, nonatomic) CGFloat coverViewAlpha;
@property (strong, nonatomic) UIColor *bottomLineBackgroundColor;
// buttomLine height
@property (assign, nonatomic) CGFloat bottomLineHeight;




@end
