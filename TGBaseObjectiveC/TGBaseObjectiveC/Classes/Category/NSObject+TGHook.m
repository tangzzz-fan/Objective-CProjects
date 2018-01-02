//
//  NSObject+TGHook.m
//  TGBaseObjectiveC
//
//  Created by 汤振治 on 02/01/2018.
//  Copyright © 2018 Centaline. All rights reserved.
//

#import "NSObject+TGHook.h"
#import <objc/message.h>

#import "TGTsetKVOSubController.h"

@implementation NSObject (TGHook)
+ (void)hookWithInstance:(id)instance method:(SEL)selector {
    Method originMethod = class_getInstanceMethod([instance class], selector);
    
    if (!originMethod) {
        // 方法不存在
    }
    
    Class newCls = [TGTsetKVOSubController class];
    
    // 修改 isa 指向
    object_setClass(instance, newCls);
    
}
@end


