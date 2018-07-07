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
typedef void (^Block)(void);

@interface XXObject : NSObject<XXProtocol>
@property (assign, nonatomic) int age;
@property (assign, nonatomic) int height;
@property (strong, nonatomic) NSString *testStr;
@property (strong, nonatomic) Block block;
@property (strong, nonatomic) NSString *name;


- (instancetype)initWithName:(NSString *)name;

+ (instancetype)objectWithFormat:(NSString *)formater;

- (void)hello;
+ (void)hellolnClass;
@end
