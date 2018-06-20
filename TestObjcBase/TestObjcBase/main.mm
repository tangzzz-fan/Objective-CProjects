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

#import "XXObject+Test.h"

#import "MJClassInfo.h"
#import "NSObject+runtime.h"




int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
    
      // 在分类中添加属性, 只是会生成对应的 get set 方法, 没有生成对应的成员变量
        // 调用 get set 方法时将传递进来的数据保存起来, 然后让他能使用,就好
      
    }
    return 0;
}
