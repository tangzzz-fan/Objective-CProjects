//
//  main.m
//  TestObjcBase
//
//  Created by MacPro on 2018/6/6.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXObject.h"
#import "XXPerson.h"

#import <malloc/malloc.h>
#import <objc/runtime.h>

#import "MJClassInfo.h"
#import "NSObject+runtime.h"




int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
    
        XXObject *object = [[XXObject alloc] init];
        [object setValue:@10 forKey:@"age"];
        
        
        NSLog(@"%zd", object->_age);
      
    }
    return 0;
}
