//
//  XXPerson.h
//  TestObjcBase
//
//  Created by MacPro on 2018/6/14.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import "XXObject.h"
@protocol PersonProtocol<NSObject>
- (void)sayMethods;
@end
@interface XXPerson : XXObject<PersonProtocol>
@property (strong, nonatomic) NSArray *testArray;


+ (void)update;
@end
