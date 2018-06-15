//
//  XXPerson.m
//  TestObjcBase
//
//  Created by MacPro on 2018/6/14.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import "XXPerson.h"

@interface XXPerson()

@end
@implementation XXPerson
+ (void)update {
    NSLog(@"This is called from update class method");
}

- (void)sayMethods {
    NSLog(@"This is say from XXPerson");
}
@end
