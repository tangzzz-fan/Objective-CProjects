//
//  Person.m
//  TestBlock
//
//  Created by 汤振治 on 2018/9/11.
//  Copyright © 2018年 Tango. All rights reserved.
//

#import "Person.h"

@implementation Person
- (void)test
{
    void(^block)(void) = ^{
        NSLog(@"%@",self.name);
        NSLog(@"%@",_name);

    };
    block();
}
- (instancetype)initWithName:(NSString *)name
{
    if (self = [super init]) {
        self.name = name;
    }
    return self;
}
+ (void) test2
{
    NSLog(@"类方法test2");
}

- (void)dealloc {
    NSLog(@"Person Dealloc");
}

@end
