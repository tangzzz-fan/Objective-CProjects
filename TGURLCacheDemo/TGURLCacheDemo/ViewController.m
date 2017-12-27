//
//  ViewController.m
//  TGURLCacheDemo
//
//  Created by MacPro on 2017/11/30.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    RACSignal *signalInterval = [RACSignal createSignal:^(id<RACSubscriber> subscriber) {
//        // 2
//        NSLog(@"subscriber sendnext");
//        // 这里是 执行定义的 nextblock block 的参数为 [nsdate date]
//        // 此处就是执行 NextBlock block
//        [subscriber sendNext:[NSDate date]];
//
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [subscriber sendNext:[NSDate date]];
//            [subscriber sendCompleted];
//        });
//
//        return (id)nil;
//    }];
//
//    // 1
//    NSLog(@"subscrib signal");
//
//    // 这里就创建了一个 subscriber, 定义了接收到数据之后的操作
//    // 这里的 next block 就定义了这个订阅者拿到信号之后做什么事(将 nextblock 绑定在 subscriber 中)
//    [signalInterval subscribeNext:^(id x) {
//        NSLog(@"next:%@", x);
//    } error:^(NSError *error) {
//        NSLog(@"error:%@", error);
//    } completed:^{
//        NSLog(@"completed");
//    }];
//
//    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        [subscriber sendNext:@"test from subscriber"];
//        return nil;
//    }];
//    [signal subscribeNext:^(id x) {
//        NSLog(@"test");
//    }];
//
//    [signalInterval bind:^RACStreamBindBlock{
//        return nil;
//    }];
    
    // 该方法使用适配器模式, 让一个订阅者订阅了这个信号
//    [signalInterval subscribe:<#(id<RACSubscriber>)#>];
    
    
    // 创建一个 订阅者, 对应要做的 next 事件, 这个 nextblock 被赋值给 订阅者,
//    + (instancetype)subscriberWithNext:(void (^)(id x))next error:(void (^)(NSError *error))error completed:(void (^)(void))completed {
//        NLSubscriber *subscriber = [[self alloc] init];
//
//        subscriber->_next = [next copy];
//        subscriber->_error = [error copy];
//        subscriber->_completed = [completed copy];
//
//        return subscriber;
//    }
//    RACSignal *signalInterval = [[RACSignal interval:1.0 onScheduler:[RACScheduler mainThreadScheduler]] take:3];
//
//    // map 将一个信号的值 反射成另一个值
//    RACSignal *mapSignal = [signalInterval flattenMap:^RACStream *(id value) {
//        return nil;
//    }];
//
//    [mapSignal subscribeNext:^(id x) {
//        NSLog(@"outer value: %@", x);
//    }];
//    RACSignal *signalInterval = [[RACSignal interval:1.0 onScheduler:[RACScheduler mainThreadScheduler]] take:3];
//
//    RACSignal *bindSignal = [signalInterval bind:^RACStreamBindBlock{
//        return ^(NSDate *value, BOOL *stop) {
//            NSLog(@"inner value: %@", value);
//
//            return [RACSignal return:value];
//        };
//    }];
//
//    [bindSignal subscribeNext:^(id x) {
//        NSLog(@"outer value: %@", x);
//    }];
//    - (instancetype)flattenMap:(RACStream * (^)(id value))block {
//        Class class = self.class;
//
//        return [self bind:^{
//            return ^(id value, BOOL *stop) {
//                // block 返回 nil, 就使用 emptySignal 代替
//                id stream = block(value) ?: [class empty];
//
//                return stream;
//            };
//        }];
//    }
    
//    bind 自己没有创建新的信号, 订阅自己, 自己的值经过 bindingBlock 就有一个新的信号 但是可以在 bindblock 中创建新的信号, 在内部, 将原来的信号, 和 bindblock 中的信号, 获取到原来的订阅者, 自己订阅传递进来的信号, 将事件转发给原来信号的订阅者
    [[[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"打蛋液");
        [subscriber sendNext:@"蛋液"];
        [subscriber sendCompleted];
        return nil;
    }] flattenMap:^RACStream *(NSString* value) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSLog(@"把%@倒进锅里面煎",value);
            [subscriber sendNext:@"煎蛋"];
            [subscriber sendCompleted];
            return nil;
        }];
    }] flattenMap:^RACStream *(NSString* value) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSLog(@"把%@装到盘里", value);
            [subscriber sendNext:@"上菜"];
            [subscriber sendCompleted];
            return nil;
        }];
    }] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    RACSignal *signal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"石"];
        return nil;
    }] map:^id(NSString* value) {
        if ([value isEqualToString:@"石"]) {
            return @"金";
        }
        return value;
    }];
    [signal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
}


@end
