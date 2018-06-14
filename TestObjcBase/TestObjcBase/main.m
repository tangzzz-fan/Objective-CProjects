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

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        XXPerson *person = [[XXPerson alloc] init];
        
        Class personClass = [XXPerson class];
        Class personMetaClass = object_getClass(personClass);
        
        // p/x personClass -> isa
        // error: member reference base type 'Class' is not a structure or union
        // 尝试找出 类对象的 isa
        // 1 isa 指针在 64 位系统下, 为了表示更多的内容, 进行了 ISA_MASK 位运算,
        // 2 系统没有开放 class->isa 指针, 此时可以使用桥接的方式查看 class->isa 的内容
        // 原因: 此时已经知道 class->isa 里面有什么东西
        // 因此可以自定义一个与之结构类似的结构体或者类 然后进行强转, 就可以看到里面的内容.

        
        NSLog(@"%p %p %p", person, personClass, personMetaClass);
        
    }
    return 0;
}
