//
//  main.m
//  TestBlock
//
//  Created by 汤振治 on 2018/9/11.
//  Copyright © 2018年 Tango. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Person.h"

//int sAge = 10;
//static int sYear = 20;

typedef void (^Block)(void);

int main(int argc, const char * argv[]) {
//    @autoreleasepool {
    
//        auto int age = 10;
//
//        static int bing = 20;
//
//        Person *person = [[Person alloc] initWithName:@"Name"];
//
//
//        void (^block)(void) = ^() {
//
//            NSLog(@"this is a block");
//            NSLog(@"this is a name %@", person.name);
//            [person test];
//            [Person test2];
//
//
//        };
//
//        age = 30;
//        bing = 40;
//        block();
//
        
//        // 1. 内部没有调用外部变量的block
//        void (^block1)(void) = ^{
//            NSLog(@"Hello");
//        };
//        // 2. 内部调用外部变量的block
//        int a = 10;
//        void (^block2)(void) = ^{
//            NSLog(@"Hello - %d",a);
//        };
//        // 3. 直接调用的block的class
//        NSLog(@"%@ %@ %@", [block1 class], [block2 class], [^{
//            NSLog(@"%d",a);
//        } class]);
        
//        Block block;
//        {
//            Person *person = [[Person alloc] init];
//            person.age = 10;
//
//            __weak Person *waekPerson = person;
//            block = ^{
//                NSLog(@"------block内部%d",waekPerson.age);
//            };
//
//
//            block();
//
//
//        } // 执行完毕，person没有被释放
//        NSLog(@"--------");
//    }
//    // person 释放, 因为 block 被释放了. 此时如果在外界对 person 做一次引用, 则是 block 被释放
//    // 这里没有在 block 执行完之后就被释放, 是因为 block 没有被回收, 此时 block 还对 person 有一个强引用.
//    // 这里什么时候 block 被销毁了? 此时的 block 为定义在函数体内部的 block, 因此出了花括号之后就会被释放.
//
//    // 使用 __weak 修饰之后, 因为 block 使用弱引用引用实例对象, 不能增加对象的引用计数, 此时出了这个括号之后, person 就会被释放

//    }
    @autoreleasepool {
//        __block int age = 10;
//        Block block = ^ {
//             age = 20; // 无法修改
//            NSLog(@"%d",age);
//        };
//        block();
//        
//        __block Person *person = [[Person alloc] init];
//        NSLog(@"%@",person);
//        Block block = ^{
//            person = [[Person alloc] init];
//            NSLog(@"%@",person);
//        };
//        block();
        int number = 20;
        __block int age = 10;
        
        NSObject *object = [[NSObject alloc] init];
        __weak NSObject *weakObj = object;
        
        Person *p = [[Person alloc] init];
        __block Person *person = p;
        __block __weak Person *weakPerson = p;
       __weak  __block Person *weakPerson2 = p;

        Block block = ^ {
            NSLog(@"%d",number); // 局部变量
            NSLog(@"%d",age); // __block修饰的局部变量
            NSLog(@"%p",object); // 对象类型的局部变量
            NSLog(@"%p",weakObj); // __weak修饰的对象类型的局部变量
            NSLog(@"%p",person); // __block修饰的对象类型的局部变量
            NSLog(@"%p",weakPerson); // __block，__weak修饰的对象类型的局部变量
            NSLog(@"%p",weakPerson2); // __block，__weak修饰的对象类型的局部变量

        };
        block();
       
    }
    return 0;
}

