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

typedef void(^TestBlock)(void);


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        __block XXObject *object = [[XXObject alloc] init];
        
        void (^VBlock)(void) = ^{
            NSLog(@"----- %@", object);
        };
        VBlock();
        
        NSLog(@"----- %p", &object);
    }
    return 0;
}
