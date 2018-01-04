//
//  TGDemo1ViewModel.h
//  TGMVVMDemo
//
//  Created by 汤振治 on 04/01/2018.
//  Copyright © 2018 Centaline. All rights reserved.
//  在 viewModel 中要处理的事件

#import "TGBaseViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface TGDemo2ViewModel : NSObject
// 使用数据层提供的数据
/** 加载数据的信号 */
@property (nonatomic, strong, readonly)  RACSignal *dataSignal;

// 错误事件处理
@property (nonatomic, strong, readonly) RACSignal *errorSignal;

// 执行网络数据请求, 上拉加载刷新  下拉加载更多 搜索等
/** 网络请求 */
@property (nonatomic, strong, readonly)  RACCommand *loadDataCommand;
@end
