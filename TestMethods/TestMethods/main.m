//
//  main.m
//  TestMethods
//
//  Created by MacPro on 2018/6/7.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXObject.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        
        XXObject *obj = [[XXObject alloc] init];

        NSString *res1 = [obj append:@"a" withStr2:@"b" andStr3:@"c"];
        
        // 最后一个参数不准确, 不能传递多个参数
        NSString *res2 = [obj performSelector:@selector(append:withStr2:andStr3:) withObject:@"a" withObject:@"b"];
        
        SEL selector = NSSelectorFromString(@"printName:");
        [obj performSelector:selector withObject:@"Tom"];
        
        NSLog(@"%@ -- %@ ", res1, res2);
        
        
    }
    return 0;
}
