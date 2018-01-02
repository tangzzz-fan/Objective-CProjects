//
//  NSObject+TGHook.h
//  TGBaseObjectiveC
//
//  Created by 汤振治 on 02/01/2018.
//  Copyright © 2018 Centaline. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (TGHook)
+ (void)hookWithInstance:(id)instance method:(SEL)selector;
@end

