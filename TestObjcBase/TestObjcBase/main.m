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

typedef void (^Block)(void);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // 在ARC 环境下.
        // 在 下面的花括号执行完了之后, person 没有被释放,因为在block 中捕获了作为局部自动变量的person, 且为强指针指向,因此 block 不被释放 person 不会被释放
        // 而要释放block, 则要释放 person.
        
        // 在 MRC 环境下, person 会被释放掉,因为 MRC 环境下, block 在栈空间, 不会对栈外空间的变量强引用.
        // MRC 下, 只要对原 block 执行一次 copy 操作, block 指向的局部变量便不会被销毁.
        
        // __weak 修饰的对象, 在对象被释放之后, 指针会被设置为 nil
        
        Block block;
        {
            XXObject *person = [[XXObject alloc] init];
            person.age = 10;
            
            block = ^{
                NSLog(@"------block内部%d",person.age);
            };
        } // 执行完毕，person没有被释放
        NSLog(@"--------");
    } // person 释放
    
    return 0;
}
