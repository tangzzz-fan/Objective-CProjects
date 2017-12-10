//
//  Status.m
//  TGBaseObjectiveC
//
//  Created by MacPro on 2017/12/10.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "Status.h"

@implementation Status
+ (instancetype)statusWithDict:(NSDictionary *)dict {
    Status *status = [[[self class] alloc] init];
    [status setValuesForKeysWithDictionary:dict];
    return status;
}

// 处理 在 KVC 中可能出现的为某个未定义的 key 赋值的方法
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"undefinedKey:, %@", key);
}
@end
