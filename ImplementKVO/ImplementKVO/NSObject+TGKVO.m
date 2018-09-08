//
//  NSObject+TGKVO.m
//  ImplementKVO
//
//  Created by 汤振治 on 2018/9/8.
//  Copyright © 2018年 Tango. All rights reserved.
//  自己实现 KVO
/*
 1 修改 isa 指针
 2 隐藏子类
 3 增加传递的参数类型
 */

#import "NSObject+TGKVO.h"
#import <objc/runtime.h>
#import <objc/message.h>
NSString *const kTGKVOClassPrefix = @"TGKVOClassPrefix_";
NSString *const kTGKVOAssociatedObservers = @"TGKVOAssociatedObservers";
// observerationInfo
#pragma mark - TGObservationInfo
@interface TGObserverationInfo: NSObject

/** observer */
@property (nonatomic, weak) NSObject *observer;
/** key */
@property (nonatomic, copy) NSString *key;
/** block */
@property (nonatomic, copy) TGObservingBlock block;

@end

@implementation TGObserverationInfo
- (instancetype)initWithObserver:(NSObject *)observer Key:(NSString *)key Block:(TGObservingBlock)block {
    if (self == [super init]) {
        _observer = observer;
        _key = key;
        _block = block;
    }
    
    return self;
    
}

@end

#pragma mark - Debug Help Methods
// print method names
static NSArray *ClassMethodNames(Class c) {
    NSMutableArray *array = [NSMutableArray array];
    
    unsigned int methodCount = 0;
    Method *methodList = class_copyMethodList(c, &methodCount);
    unsigned int i;
    for (i = 0; i < methodCount; i ++) {
        // get methond name list
        [array addObject:NSStringFromSelector(method_getName(methodList[i]))];
    }
    
    free(methodList);
    
    return array;
}

#pragma mark - Helpers
// get getter from setter
static NSString *getterForSetter(NSString *setter) {
    if (setter.length <= 0 || [setter hasPrefix:@"set"] || ![setter hasPrefix:@":"]) {
        return nil;
    }
    
    NSRange range = NSMakeRange(3, setter.length - 4);
    NSString *key = [setter substringWithRange:range];
    
    NSString *firstLetter = [[key substringToIndex:1] lowercaseString];
    key = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:firstLetter];
    
    return key;
    
}

// get setter form getter
static NSString * setterForGetter(NSString *getter) {
    if (getter.length <= 0) {
        return nil;
    }
    
    // upper case the first letter
    NSString *firstLetter = [[getter substringToIndex:1] uppercaseString];
    NSString *remainingLetters = [getter substringFromIndex:1];
    
    // add set
    NSString *setter = [NSString stringWithFormat:@"set%@%@:", firstLetter, remainingLetters];
    
    return setter;
}

#pragma mark - Overridden Methods
static void kvo_setter(id self, SEL _cmd, id newValue) {
    NSString *setterName = NSStringFromSelector(_cmd);
    NSString *getterName = getterForSetter(setterName);
    
    if (!getterName) {
        NSString *reason = [NSString stringWithFormat:@"Object %@ does not have setter %@", self, setterName];
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil];
        return;
    }
    
    id oldValue = [self valueForKey:getterName];
    
    // a new superClass
    struct objc_super superclazz = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    
    void (*objc_msgSendSuperCasted)(void *, SEL, id) = (void *)objc_msgSendSuper;
    
    // call super's setter, which is original class's setter method
    objc_msgSendSuperCasted(&superclazz, _cmd, newValue);
    
    // look up observers and call the blocks
    // 使用关联对象的方式存储要使用的 block
    NSMutableArray *observers = objc_getAssociatedObject(self, (__bridge const void *)(kTGKVOAssociatedObservers));
    for (TGObserverationInfo *each in observers) {
        if ([each.key isEqualToString:getterName]) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                each.block(self, getterName, oldValue, newValue);
            });
        }
    }
}

// customer class
static Class kvo_class(id self, SEL _cmd) {
    return class_getSuperclass(object_getClass(self));
}


@implementation NSObject (TGKVO)

- (void)TG_addObserver:(NSObject *)observer forKey:(NSString *)key withBlock:(TGObservingBlock)block {
    SEL setterSelector = NSSelectorFromString(setterForGetter(key));
    Method setterMethod = class_getInstanceMethod([self class], setterSelector);
    if (!setterMethod) {
        NSString *reason = [NSString stringWithFormat:@"Object %@ does not have a setter for key %@", self, key];
        @throw [NSException exceptionWithName:NSInvalidArgumentException
                                       reason:reason
                                     userInfo:nil];
        
        return;
    }
    
    Class clazz = object_getClass(self);
    NSString *clazzName = NSStringFromClass(clazz);
    
    // if not an KVO class yet
    if (![clazzName hasPrefix:kTGKVOClassPrefix]) {
        clazz = [self makeKvoClassWithOriginalClassName:clazzName];
        object_setClass(self, clazz);
    }
    
    // add our kvo setter if this class (not superclasses) doesn't implement the setter?
    if (![self hasSelector:setterSelector]) {
        const char *types = method_getTypeEncoding(setterMethod);
        class_addMethod(clazz, setterSelector, (IMP)kvo_setter, types);
    }
    
    TGObserverationInfo *info = [[TGObserverationInfo alloc] initWithObserver:observer Key:key Block:block];
    NSMutableArray *observers = objc_getAssociatedObject(self, (__bridge const void *)(kTGKVOAssociatedObservers));
    if (!observers) {
        observers = [NSMutableArray array];
        objc_setAssociatedObject(self, (__bridge const void *)(kTGKVOAssociatedObservers), observers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [observers addObject:info];
}

- (void)TG_removeObserver:(NSObject *)observer forKey:(NSString *)key
{
    NSMutableArray* observers = objc_getAssociatedObject(self, (__bridge const void *)(kTGKVOAssociatedObservers));
    
    TGObserverationInfo *infoToRemove;
    for (TGObserverationInfo* info in observers) {
        if (info.observer == observer && [info.key isEqual:key]) {
            infoToRemove = info;
            break;
        }
    }
    
    [observers removeObject:infoToRemove];
}


- (Class)makeKvoClassWithOriginalClassName:(NSString *)originalClazzName {
    
    NSString *kvoClazzName = [kTGKVOClassPrefix stringByAppendingString:originalClazzName];
    Class clazz = NSClassFromString(kvoClazzName);
    
    if (clazz) {
        return clazz;
    }
    
    // class doesn't exist yet, make it
    Class originalClazz = object_getClass(self);
    Class kvoClazz = objc_allocateClassPair(originalClazz, kvoClazzName.UTF8String, 0);
    
    // grab class method's signature so we can borrow it
    Method clazzMethod = class_getInstanceMethod(originalClazz, @selector(class));
    const char *types = method_getTypeEncoding(clazzMethod);
    class_addMethod(kvoClazz, @selector(class), (IMP)kvo_class, types);
    
    objc_registerClassPair(kvoClazz);
    
    return kvoClazz;
}


- (BOOL)hasSelector:(SEL)selector {
    
    Class clazz = object_getClass(self);
    unsigned int methodCount = 0;
    Method* methodList = class_copyMethodList(clazz, &methodCount);
    for (unsigned int i = 0; i < methodCount; i++) {
        SEL thisSelector = method_getName(methodList[i]);
        if (thisSelector == selector) {
            free(methodList);
            return YES;
        }
    }
    
    free(methodList);
    return NO;
}


@end
