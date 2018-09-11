//
//  Person.h
//  TestBlock
//
//  Created by 汤振治 on 2018/9/11.
//  Copyright © 2018年 Tango. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
/** string */
@property (nonatomic, copy) NSString *name;
/** age */
@property (nonatomic, assign) int age;
- (instancetype)initWithName:(NSString *)name;

- (void)test;

+ (void)test2;

@end
