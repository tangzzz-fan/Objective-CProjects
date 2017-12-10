//
//  NSObject+Extension.m
//  TGBaseObjectiveC
//
//  Created by MacPro on 2017/12/10.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "NSObject+Extension.h"

@implementation NSObject (Extension)
+ (void)createPropertyDisWithDict:(NSDictionary *)dict {
    NSMutableString *strM = [NSMutableString string];
    
    // 遍历字典
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull propertyName, id  _Nonnull value, BOOL * _Nonnull stop) {
        
        NSString *type = @"";
        NSLog(@"propertyName:%@, value type:%@", propertyName, [value class]);
        
        // cgfloat 类型不能转换
        if ([value isKindOfClass:NSClassFromString(@"__NSCFString")]) {
            type = @"NSString";
        } else if ([value isKindOfClass:NSClassFromString(@"__NSCFNumber")]) {
            type = @"int";
        } else if ([value isKindOfClass:NSClassFromString(@"__NSCFArray")]) {
            type = @"NSArray";
        } else if ([value isKindOfClass:NSClassFromString(@"__NSCFDictionary")]) {
            type = @"NSDictionary";
        }
        
        NSString *str = @"";
        if ([type hasPrefix:@"NS"]) {
            str = [NSString stringWithFormat:@"@property (nonatomic, strong) %@ *%@;", type, propertyName];
        } else {
            str = [NSString stringWithFormat:@"@property (nonatomic, assign) %@ %@;", type, propertyName];
        }
        
        [strM appendFormat:@"\n%@\n", str];
    }];
    
    NSLog(@"%@", strM);
}
@end
