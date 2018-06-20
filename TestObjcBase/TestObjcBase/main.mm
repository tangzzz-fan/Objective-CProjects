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

typedef void(^TESTBlock)(void);


// 在MRC 中, 因为跨函数操作, 出现访问的数据出错
TESTBlock myblock() {
    int testAge = 10;
    return ^{
//        NSLog(@"函数调用, 返回一个 block %d", testAge);
        NSLog(@"函数调用, 返回一个 block");

    };
}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // MRC 环境下
        // 三种 block 类型: melloc, stack, global
        // 1 是否访问了 auto 变量
        // 2 存放的位置: 堆还是栈
        
//        int age = 0;
//        void (^block)() = ^(void){
//            NSLog(@"this is a global block");
//            NSLog(@"age %d", age); // 访问 auto 变量
//        };
//
//        block();
        
        // ARC 环境下, 会根据情况自动将站上的block 赋值到对上, 比如以下情况
        // 1 block 作为函数返回值, 会自动执行一次 copy 操作
        // 输出: ARC: melloac  MRC: Stack---> 多了一次copy 操作(被一个强指针指向,则执行copy, 如果是没有一个强指针指向了, 则会执行 release操作(编译器完成))
        TESTBlock block = myblock();
        block();
        NSLog(@"%@", [block class]);
        
        NSLog(@"no change, 没有访问 auto 变量, 没有执行copy 方法 %@", [^{
            NSLog(@"no change");
        } class]);
        
        // block 中定义的函数指针(该block 的生命周期) 如果在堆上则一般比在栈上要长
    }
    return 0;
}
