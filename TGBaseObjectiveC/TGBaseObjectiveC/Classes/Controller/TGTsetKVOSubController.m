//
//  TGTsetKVOSubController.m
//  TGBaseObjectiveC
//
//  Created by 汤振治 on 02/01/2018.
//  Copyright © 2018 Centaline. All rights reserved.
//

#import "TGTsetKVOSubController.h"
#import <objc/message.h>

@interface TGTsetKVOSubController ()

@end

@implementation TGTsetKVOSubController

- (void)viewDidLoad {
    [super viewDidLoad];
}
// 重写 eat 方法, 调用原方法实现
- (void)eat {
    NSLog(@"newSubClass eat");
    
    // 设置消息接受为这个子类
    
    // 绑定接受者为自己, 设置自己的父类就是原来的父类
    struct objc_super superClass = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    
    // 调用原来的方法
    void (*objc_msgSendSuperCasted)(void *, SEL) = (void *)objc_msgSendSuper;
    
    objc_msgSendSuperCasted(&superClass, _cmd);
    
}

@end
