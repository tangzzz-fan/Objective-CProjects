//
//  Student+Extension.m
//  TGBaseObjectiveC
//
//  Created by MacPro on 2017/12/10.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "Student+Extension.h"

#import <objc/message.h>

//利用静态变量地址唯一不变的特性
static const char *key = "name";

@implementation Student (Extension)
- (NSString *)name {
    return objc_getAssociatedObject(self, key);
}

- (void)setName:(NSString *)name {
    // 第一个参数：给哪个对象添加关联
    // 第二个参数：关联的key，通过这个key获取
    // 第三个参数：关联的value
    // 第四个参数:关联的策略
    objc_setAssociatedObject(self, key, name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
