//
//  main.m
//  TestObjcBase
//
//  Created by MacPro on 2018/6/6.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXObject.h"
#import <malloc/malloc.h>
#import <objc/runtime.h>

#import "NSObject+Test.h"

struct XXObject_IMPL {
    Class isa;
    int _no;
    int _age;
};

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        XXObject *object = [[XXObject alloc] init];
        object -> _no = 4;
        object -> _age = 5;
        [object hello];
        
        NSLog(@"%zd", sizeof(struct XXObject_IMPL));
        // 类中存储的实例对象至少需要的内存大小
        NSLog(@"%zd", class_getInstanceSize([XXObject class]));
        // 实际分配的对象的内存大小(内存分配方式 16 的倍数)
        NSLog(@"%zd", malloc_size((__bridge const void *)(object)));
        
        Class objectClass1 = [object class];
        Class objectClass2 = [XXObject class];
        Class objectClass3 = object_getClass(object);
        NSLog(@"%p -- %p -- %p", objectClass1, objectClass2, objectClass3);
        
        // 元类对象 对类对象获取 class 对象
        Class objMetaClass = object_getClass([NSObject class]);
        //
        Class objMetaClass1 = object_getClass([[NSObject class] class]);

        NSLog(@"%p -- %p", objMetaClass, objMetaClass1);
     
        [NSObject test];
    }
    return 0;
}
