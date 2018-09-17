//
//  main.m
//  TestMThread
//
//  Created by 汤振治 on 2018/9/14.
//  Copyright © 2018年 Tango. All rights reserved.
//

#import <Foundation/Foundation.h>
void test() {
    NSObject* obj = [NSObject new];
    @synchronized (obj) {
        
    }
}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        test();
    }
    return 0;
}


