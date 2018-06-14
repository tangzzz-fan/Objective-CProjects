//
//  XXObject.h
//  TestObjcBase
//
//  Created by MacPro on 2018/6/8.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXObject : NSObject
{
    // 声明成员变量
    @public
    // isa 8
    int _no; // 4
    int _age; // 4
}
@property (assign, nonatomic) int height;

- (void)hello;
+ (void)hellolnClass;
@end
