//
//  Person.h
//  TGBaseObjectiveC
//
//  Created by MacPro on 2017/12/10.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
+ (void)eat;
- (void)eat;

+ (void)read:(NSString *)book;
- (void)read:(NSString *)book;

+ (instancetype)running;
- (void)working;

//- (void)buy;

@end
