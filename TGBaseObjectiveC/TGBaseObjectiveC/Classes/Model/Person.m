//
//  Person.m
//  TGBaseObjectiveC
//
//  Created by MacPro on 2017/12/10.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "Person.h"

#import <objc/message.h>


@implementation Person

//+ (void)load {
//    NSLog(@"load in a super class");
//}

//+ (void)initialize {
//    NSLog(@"initialize in a superClass");
//}

+ (void)eat {
    NSLog(@"eat in a class method");
}

- (void)eat {
    NSLog(@"eat in instance method");
}

+ (void)read:(NSString *)book {
    NSLog(@"i am reading a book in a class method, %@", book);
}

- (void)read:(NSString *)book {
    NSLog(@"i am reading a book in a instance method, %@", book);
}

+ (instancetype)running {
    Person *person = [[Person alloc] init];
    NSLog(@"i am running in a class method called running");
    return person;
}

- (void)working {
    NSLog(@"this is a method called in instance method");
}



/** 处理未实现的方法
 *  重写系统的 resolveInstanceMethod/resolveClassMethod 方法,
 *  处于消息处理的动态方法解析阶段(重定向)
 *  向一个对象发送没有实现的方法, 在这个对象中定义一个万能处理函数, 这个对象所有没有实现的方法都在这个方法中处理, 做重定向, 或者是统一实现都可以
 *  class_addMethod() 参数
 *  typeCoding
 */
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(buy)) {
        class_addMethod(self, @selector(buy), (IMP)buy, "v@:");
    } else if (sel == @selector(workhard:)) {
        class_addMethod(self, @selector(workhard:), (IMP)workhard, "v@:@");
    }
    return [super resolveInstanceMethod:sel];
}

#pragma mark - Private Static Method
void buy(id self, SEL sel) {
    NSLog(@"this is a method called buy, which is not implemented by Person");
}

void workhard (id self, SEL sel, id param) {
    NSLog(@"workhard with object, sel:%@ param:%@", NSStringFromSelector(sel), param);
}

@end
