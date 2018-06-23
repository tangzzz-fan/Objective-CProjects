//
//  XXObject.m
//  TestObjcBase
//
//  Created by MacPro on 2018/6/8.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import "XXObject.h"

@implementation XXObject
- (void)hello {
    NSLog(@"hello");
}

+ (void)hellolnClass {
    
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- initWithName:(NSString *)name {
    if (self = [super init]) {
        // self.name = name
    }
    return self;
}

// protocol
- (void)sayHello {
 
}

- (void)dealloc {
    NSLog(@"-------- %s", __func__);
}

@end
