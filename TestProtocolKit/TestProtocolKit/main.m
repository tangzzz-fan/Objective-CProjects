//
//  main.m
//  TestProtocolKit
//
//  Created by MacPro on 2017/12/21.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKProtocolExtension.h"
#import "TestModel.h"

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

- (void)fizz {
    
}


@end
@interface TestObject:NSObject<TestProtocol>
- (void)fizz;
@end

@implementation TestObject
- (void)fizz {
    
}

+ (void)load {
    NSLog(@"class name %@", [self class]);
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        TestObject *object = [TestObject new];
        [object buzz];
        
        
    }
    return 0;
}
