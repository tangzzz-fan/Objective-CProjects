//
//  main.m
//  TestObjcBase
//
//  Created by MacPro on 2018/6/6.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TestRunloop.h"
#import "XXObject.h"
#import "XXPerson.h"


#import <malloc/malloc.h>
#import <objc/runtime.h>

#define TLog(_var) ({ NSString *name = @#_var; NSLog(@"%@: %@ -> %p : %@  %d", name, [_var class], _var, _var, (int)[_var retainCount]); })


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // 获取实例占用大小. 8+1+1+1 = 11 => 16 内存对齐(16的倍数)
//        NSLog(@"%zd", class_getInstanceSize([XXPerson class]));
        XXPerson *person  = [[XXPerson alloc] init];
        person.tall = YES;
        person.rich = NO;
        person.handsome = YES;
        NSLog(@"tall : %d, rich : %d, handsome : %d", person.tall,person.rich,person.handsome);
    

    }
    return 0;
}
