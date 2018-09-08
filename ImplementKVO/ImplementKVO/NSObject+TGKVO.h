//
//  NSObject+TGKVO.h
//  ImplementKVO
//
//  Created by 汤振治 on 2018/9/8.
//  Copyright © 2018年 Tango. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TGObservingBlock)(id observedObject, NSString *observedKey, id oldValue, id newValue);

@interface NSObject (TGKVO)
/** 提供一个关联方法 添加观察者 并使用 block 进行调用 */
- (void)TG_addObserver:(NSObject *)observer
                forKey:(NSString *)key
             withBlock:(TGObservingBlock)block;

/** 移除观察者对象 */
- (void)TG_removeObserver:(NSObject *)observer forKey:(NSString *)key;

@end
