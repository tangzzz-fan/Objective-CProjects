//
//  Student.m
//  TGBaseObjectiveC
//
//  Created by MacPro on 2017/12/10.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "Student.h"



@implementation Student
//+ (void)load {
//    NSLog(@"load in a subClass");
//}

//+ (void)initialize {
//    NSLog(@"initialize in a subClass");
//}
- (void)test {
    NSLog(@"in a SubClass instance method called:===== self:%@, [self class]: %@, [super class]: %@, [self superClass]: %@, [[self class] class]: %@, [[self class] superclass]: %@", self, [self class], [super class], [self superclass], [[self class] class], [[self class] superclass]);
}

+ (void)test {
    NSLog(@"in a SuperClass Class method called:===== self:%@, [self class]: %@, [super class]: %@, [self superClass]: %@, [[self class] class]: %@, [[self class] superclass]: %@", self, [self class], [super class], [self superclass], [[self class] class], [[self class] superclass]);
}

@end
