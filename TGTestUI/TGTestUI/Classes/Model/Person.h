//
//  Person.h
//  TGTestUI
//
//  Created by 汤振治 on 2018/9/11.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
/** int age */
@property (nonatomic, assign) int age;

- (instancetype)initWithAge:(int)age;
@end
