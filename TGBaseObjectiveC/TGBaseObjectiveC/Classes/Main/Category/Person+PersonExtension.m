//
//  Person+PersonExtension.m
//  TGBaseObjectiveC
//
//  Created by MacPro on 2017/12/10.
//  Copyright © 2017年 Centaline. All rights reserved.
//  测试交换 Psrson 中没有实现某个方法

#import "Person+PersonExtension.h"

#import <objc/message.h>

@implementation Person (PersonExtension)

+ (void)load {
    
//    Method running = class_getClassMethod(self, @selector(running));
//    Method runningIn = class_getClassMethod(self, @selector(runningIn));
//    method_exchangeImplementations(running, runningIn);
    
    
    Method working = class_getInstanceMethod(self, @selector(working));
    Method workingIn = class_getInstanceMethod(self, @selector(workingIn));
    method_exchangeImplementations(working, workingIn);

}

+ (instancetype)runningIn {
    
    Person *person = [self runningIn];
    
    NSLog(@"i am running in a categery method called runningIn");
    
    return person;
}

- (void)workingIn {
    
    NSLog(@"before method exchange");
    [self workingIn];
    NSLog(@"adter method exchange");

}
@end
