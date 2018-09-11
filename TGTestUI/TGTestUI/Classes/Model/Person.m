//
//  Person.m
//  TGTestUI
//
//  Created by 汤振治 on 2018/9/11.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import "Person.h"

@implementation Person
- (instancetype)initWithAge:(int)age {
    if (self = [super init]) {
        self.age = age;
    }
    return self;
}
- (void)dealloc {
    NSLog(@"Person Dealloc");
}
@end
