//
//  Person.m
//  TGBaseObjectiveC
//
//  Created by MacPro on 2017/12/10.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "Person.h"

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

@end
