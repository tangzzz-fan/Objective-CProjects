//
//  main.m
//  TestObjcBase
//
//  Created by MacPro on 2018/6/6.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TestRunloop.h"

#import <malloc/malloc.h>
#import <objc/runtime.h>


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        TestRunloop *runloop = [[TestRunloop alloc] init];
        [runloop testRunloop];
        
    }
    return 0;
}
