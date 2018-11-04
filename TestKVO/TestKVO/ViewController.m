//
//  ViewController.m
//  TestKVO
//
//  Created by MacPro on 2018/6/6.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testGCD];
}

- (void)testGCD {
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_async(mainQueue, ^{
        NSLog(@"this is in mainQueue async");
    });
    NSLog(@"1111");
}

- (void)testKVO {
    Person *p1 = [[Person alloc] init];
    Person *p2 = [[Person alloc] init];
    
    p1.age = 1;
    p1.age = 2;
    p2.age = 2;
    
    // 监听 p1 age 属性
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    // 通过methodForSelector找到方法实现的地址
    NSLog(@"添加KVO监听之前 - p1 = %p, p2 = %p", [p1 methodForSelector: @selector(setAge:)],[p2 methodForSelector: @selector(setAge:)]);
    
    
    // 设置添加观察. 在p1 对象上添加观察的设置
    [p1 addObserver:self forKeyPath:@"age" options:options context:nil];
    
    NSLog(@"添加KVO监听之后 - p1 = %p, p2 = %p", [p1 methodForSelector: @selector(setAge:)],[p2 methodForSelector: @selector(setAge:)]);
    p1.age = 30;
    [self printMthods: object_getClass(p1)];
    [self printMthods: object_getClass(p2)];
    
    
    [p1 removeObserver:self forKeyPath:@"age"];
}


- (void)printMthods:(Class)cls {
    unsigned int count ;
    // 获取方法名
    Method *methods = class_copyMethodList(cls, &count);
    NSMutableString *methodNames = [NSMutableString string];
    [methodNames appendFormat:@"%@ - ", cls];
    
    for (int i = 0 ; i < count; i++) {
        Method method = methods[i];
        NSString *methodName  = NSStringFromSelector(method_getName(method));
        
        [methodNames appendString: methodName];
        [methodNames appendString:@" "];
        
    }
    
    NSLog(@"%@",methodNames);
    free(methods);
    
}


// 调用对应的方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"监听到 %@ 的 %@ 的改变了 --> %@", object, keyPath, change);
}


@end
