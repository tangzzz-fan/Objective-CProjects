//
//  TGStyle.m
//  TGTestUI
//
//  Created by MacPro on 2017/12/28.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "TGStyle.h"

@implementation TGStyle

+ (instancetype)sharedInstance {
    static TGStyle *style = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        style = [[TGStyle alloc] init];
    });
    return style;
}
@end
