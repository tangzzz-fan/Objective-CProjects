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
@property (assign, nonatomic) float titleMarign;

@property (strong, nonatomic) UIFont *titleFont;

@end
