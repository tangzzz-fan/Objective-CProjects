//
//  main.m
//  TestProtocolKit
//
//  Created by MacPro on 2017/12/21.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKProtocolExtension.h"

@protocol TestProtocol<NSObject>
@required

- (void)fizz;

@optional

- (void)buzz;
@end

@defs(TestProtocol)

- (void)buzz {
    NSLog(@"Buzz");
}

@end
@interface TestObject:NSObject<TestProtocol>

@end

@implementation TestObject
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        TestObject *object = [TestObject new];
        [object buzz];
    }
    return 0;
}
