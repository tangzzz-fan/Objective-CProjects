//
//  main.m
//  TestObjcBase
//
//  Created by MacPro on 2018/6/6.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXObject.h"
#import "XXPerson.h"

#import <malloc/malloc.h>
#import <objc/runtime.h>

#import "MJClassInfo.h"
#import "NSObject+runtime.h"




int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        struct mj_objc_class *xxobjectClass = (__bridge struct mj_objc_class *)([XXObject class]);
        struct mj_objc_class *xxpersonClass = (__bridge struct mj_objc_class *)([XXPerson class]);
        
        class_rw_t *xxobjectClassData = xxobjectClass->data();
        class_rw_t *xxpersonClassData = xxpersonClass->data();
        
        // 查看类方法位置 -> metaClass
        // object_getClass([XXObject class]);
        
        
        XXObject *object = [[XXObject alloc] init];
        [object sayHello];
        
        XXPerson *person = [[XXPerson alloc] init];
        [person sayHello];
        [person sayMethods];
        
        [XXObject getAllMethods];
//        [XXPerson getAllProperties];
        
        NSLog(@"1111");
      
    }
    return 0;
}
