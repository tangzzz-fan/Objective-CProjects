//
//  NSObject+Extension.m
//  TGBaseObjectiveC
//
//  Created by MacPro on 2017/12/10.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "NSObject+Extension.h"

#import <objc/message.h>

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
        } else if ([value isKindOfClass:NSClassFromString(@"__NSCFBoolean")]) {
            type = @"BOOL";
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

/** runtime 遍历模型中的所有成员变量, 去字典中查找
 *  ivar 成员变量
 *  class_copyIvarList
 *  Ivar *: 指向 一个成员变量数组
 *  class :  获取类的成员变量列表
 *  count : 成员变量的个数
 */
+ (instancetype)modelWithDict:(NSDictionary *)dict {
    id objc = [[[self class] alloc] init];
    
    unsigned int count = 0;
    // 获取成员变量列表
    Ivar *ivarList = class_copyIvarList(self, &count);
    
    for (NSInteger i = 0; i < count; i++) {
        
        Ivar ivar = ivarList[i];
        
        // 将 char * 字符串转换成 string
        NSString *propertyName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        // 获取成员变量类型
        NSString *propertyType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        
//        NSLog(@"propertyName: %@ propertyType: %@", propertyName, propertyType);
        // 获取 key
        NSString *key = [propertyName substringFromIndex:1];
    
        // 获取字典的 value
        id value = dict[key];
        
        // 使用 kvc 赋值
        // 二阶字典转模型 如果模型中的属性定义就是字典就不用转换
        if ([value isKindOfClass:[NSDictionary class]] && ![propertyType hasPrefix:@"NS"]) {
            
            // 此时 propertyType 中为 @"User" 不是想要的 User 类型
            propertyType = [propertyType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            propertyType = [propertyType substringFromIndex:1];
            NSLog(@"propertyName: %@ propertyType: %@, value: %@", propertyName, propertyType, value);

            Class subModelClass = NSClassFromString(propertyType);
            if (subModelClass) {
                value = [subModelClass modelWithDict:value];
            }
        }
        
        if (value) {
            [objc setValue:value forKey:key];
        }
    }
    
    return objc;
}
@end
