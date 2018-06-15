//
//  NSObject+runtime.h
//  TestObjcBase
//
//  Created by MacPro on 2018/6/15.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (runtime)
+ (NSArray *)getAllMethods;
+ (NSArray *)getAllProperties;
+ (NSDictionary *)getAllPropertiesAndVaules:(NSObject *)obj;
@end
