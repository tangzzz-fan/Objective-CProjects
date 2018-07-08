//
//  XXPerson.m
//  TestObjcBase
//
//  Created by MacPro on 02/07/2018.
//  Copyright © 2018 Centaline. All rights reserved.
//

#import "XXPerson.h"

@implementation XXPerson
- (void)print {
    NSLog(@"my name is %@", self.name);
}

- (void)dealloc {
    NSLog(@"XXPerson delloc %@", self);
}

@end
