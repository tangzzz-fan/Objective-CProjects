//
//  Student.h
//  TGBaseObjectiveC
//
//  Created by MacPro on 2017/12/10.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "Person.h"

@interface Student : Person
@property (strong, nonatomic) NSString *name;
- (void)test;

+ (void)test;
@end
