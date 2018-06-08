//
//  main.m
//  debug-objc
//
//  Created by suchavision on 1/24/17.
//
//

#import <Foundation/Foundation.h>
//#import "XXObject.h"
//#import "NSObject+Sark.h"

@interface NSObject (Sark)
+ (void)foo;
@end

@implementation NSObject (Sark)
- (void)foo {
    NSLog(@"IMP: -[NSObject foo]");
}
@end
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        [NSObject foo];
        [[NSObject new] foo];
    }
    return 0;
}
