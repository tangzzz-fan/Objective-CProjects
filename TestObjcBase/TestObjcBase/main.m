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

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        XXObject *object = [[XXObject alloc] init];
        NSLog(@"%zd", class_getInstanceSize([XXObject class]));
        NSLog(@"%zd", malloc_size((__bridge const void *)(object)));
    }
    return 0;
}
