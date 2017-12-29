//
//  TGStyle.m
//  TGTestUI
//
//  Created by MacPro on 2017/12/28.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "TGStyle.h"

@implementation TGStyle
// 提供默认初始化方法
- (instancetype)init {
    if (self = [super init]) {
        self.isScrollAble = NO;
        self.isScrollToMiddle = NO;
        self.isShowCoverView = YES;
        self.isShowBottomLine = YES;
        self.titleMarign = 16;
        self.coverMargin = 16;
        self.coverHeight = 30;
        self.titleFont = [UIFont systemFontOfSize:15];
        self.normalColor = [UIColor blackColor];
        self.selectedColor = [UIColor redColor];
        self.bottomLineBackgroundColor = [UIColor redColor];
        self.bottomLineHeight = 2;
        self.coverViewAlpha = 0;
    }
    return self;
}
@end
