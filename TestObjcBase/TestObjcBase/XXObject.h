//
//  XXObject.h
//  TestObjcBase
//
//  Created by MacPro on 2018/6/8.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XXProtocol<NSObject>
- (void)sayHello;
@end

@interface XXObject : NSObject<XXProtocol>

@property (assign, nonatomic) int height;
@property (strong, nonatomic) NSString *testStr;

- (void)hello;
+ (void)hellolnClass;
@end
