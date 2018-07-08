//
//  XXObject.m
//  TestMethods
//
//  Created by MacPro on 2018/6/7.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import "XXObject.h"

@implementation XXObject
- (instancetype)init {
    if (self = [super init]) {
        // 初始化自己的方法名 生成invocation 可以认为在初始化时进行绑定
    }
    return self;
}

- (void)hello {
    NSLog(@"Hello World");
}
- (void)printName:(NSString *)name {
    NSLog(@"I am %@", name);
}
- (NSString *)append:(NSString *)str1 withStr2:(NSString *)str2 andStr3:(NSString *)str3 {
    NSString *str = [str1 stringByAppendingString:str2];
    str = [str stringByAppendingString:str3];
    return str;
}

@end
