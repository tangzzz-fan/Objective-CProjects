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
        XXPerson *person = [[XXPerson alloc] init];
        person.name = @"this is xiaoming";
//        {
//            __weak typeof(person) weakPerson;
//            void (^testBlock)(void) = ^{
//                __strong typeof(weakPerson) strongPerson;
//                strongPerson.name = @"xiaoming";
//                NSLog(@"a changed: %@", strongPerson.name);
//            };
//            testBlock();
//            NSLog(@"ssss xiaoming changed: %@", person.name);
//        }
        {
            __block XXPerson *bPerson = person;
            void (^testBlock)(void) = ^{
                bPerson.name = @"xiaoming";
                NSLog(@"a changed: %@ -- %@", bPerson.name, bPerson);
            };
            testBlock();
            NSLog(@"ssss xiaoming changed: %@", person.name);
        }
        NSLog(@"person: %@", person.name);

    }
    return 0;
}
