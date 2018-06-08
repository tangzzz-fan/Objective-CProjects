//
//  main.m
//  TestObjcBase
//
//  Created by MacPro on 2018/6/6.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXObject.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        XXObject *object = [[XXObject alloc] init];
        [object hello];
    }
    return 0;
}
