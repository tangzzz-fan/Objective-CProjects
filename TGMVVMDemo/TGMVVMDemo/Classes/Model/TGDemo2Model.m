//
//  TGDemo2Model.m
//  TGMVVMDemo
//
//  Created by 汤振治 on 04/01/2018.
//  Copyright © 2018 Centaline. All rights reserved.
//

#import "TGDemo2Model.h"
#import <Mantle.h>
#import "TGHotel.h"
#import "TGScenic.h"

@implementation TGDemo2Model
// 网络请求时, 要防止出现副作用
- (RACSignal *)loadTravelData {
    // 模拟网络连接 获取 json 数据
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        NSLog(@"正在执行 加载 travelData 的网络请求");
        // 模拟网络延时
        [NSThread sleepForTimeInterval:1];
        
        // 模拟0.25 发生网络错误
        NSInteger randNumber = arc4random();
        if (randNumber % 4 == 0) {
            NSError *error = [NSError errorWithDomain:@"Bad Network" code:500 userInfo:@{}];
            [subscriber sendError:error];
            return nil;
        }
        
        // 从本地加载 json 数据
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Demo2TravelData" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSError *error = nil;
        
        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        if (error) {
            [subscriber sendError:error];
        } else {
            NSArray *scenicData = jsonData[@"data"];
            if (!scenicData) {
                [subscriber sendError:[NSError errorWithDomain:@"Error JSON Data" code:500 userInfo:@{}]];
            } else {
                
                NSArray *scenicArray = [MTLJSONAdapter modelsOfClass:TGScenic.class fromJSONArray:scenicData error:&error];
                
                if (error) {
                    [subscriber sendError:error];
                } else {
                    [subscriber sendNext:scenicArray];
                    [subscriber sendCompleted];
                }
            }
        }
        
        return [RACDisposable disposableWithBlock:^{
            // 执行网络请求的清理工作
        }];
    }] subscribeOn:[RACScheduler schedulerWithPriority:DISPATCH_QUEUE_PRIORITY_DEFAULT]];
}

- (RACSignal *)loadHotelData {
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        NSLog(@"正在执行 加载 HotelData 的网络请求");
        // 模拟网络延时
        [NSThread sleepForTimeInterval:1];
        
        // 模拟0.25 发生网络错误
//        NSInteger randNumber = arc4random();
//        if (randNumber % 4 == 0) {
//            NSError *error = [NSError errorWithDomain:@"Bad Network" code:500 userInfo:@{}];
//            [subscriber sendError:error];
//            return nil;
//        }
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Demo2HotelData" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSError *error = nil;
        
        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error ];
        
        if (error) {
            [subscriber sendError:error];
        } else {
            NSArray *hotelData = jsonData[@"data"];
            if (!hotelData) {
                [subscriber sendError:[NSError errorWithDomain:@"Error JSON Data" code:500 userInfo:@{}]];
            } else {
                NSArray *hotelArray = [MTLJSONAdapter modelsOfClass:TGHotel.class fromJSONArray:hotelData error:&error ];
                
                if (error) {
                    [subscriber sendError:error];
                } else {
                    [subscriber sendNext:hotelArray];
                    [subscriber sendCompleted];
                }
            }
        }
        
        return [RACDisposable disposableWithBlock:^{
            // 执行信号的清理工作
        }];
    }] subscribeOn:[RACScheduler schedulerWithPriority:DISPATCH_QUEUE_PRIORITY_DEFAULT]];
}
@end
