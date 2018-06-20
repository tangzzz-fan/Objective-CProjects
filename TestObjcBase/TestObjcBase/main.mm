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

#import "XXObject+Test.h"

#import "MJClassInfo.h"
#import "NSObject+runtime.h"




int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // MRC 环境下
        // 三种 block 类型: melloc, stack, global
        // 1 是否访问了 auto 变量
        // 2 存放的位置: 堆还是栈
        void (^block)() = ^(void){
            NSLog(@"this is a global block");
        };
        
        block();
      
    }
    return 0;
}
