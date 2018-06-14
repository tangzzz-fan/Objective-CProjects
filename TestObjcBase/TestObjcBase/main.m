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
        
        Class objectClass = [object class];
        Class objectClass2 = [XXObject class];
        Class objectClass3 = object_getClass(object);
        NSLog(@"asdsa");
    }
    return 0;
}
