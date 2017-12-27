//
//  LoginViewModel.h
//  TGRacDemo
//
//  Created by 汤振治 on 26/12/2017.
//  Copyright © 2017 Centaline. All rights reserved.
//  这里拥有登录的逻辑, 需要给 view 提供的数据

#import <Foundation/Foundation.h>

#import <ReactiveCocoa/ReactiveCocoa.h>


@interface LoginViewModel : NSObject
/** userName */
@property (nonatomic, copy) NSString *userName;
/** pwd */
@property (nonatomic, copy) NSString *password;

// 数据流向部分的信号 或者执行命名
// 此处比如 在 viewController 中要使用到 按钮的使能状态, 要给 ViewController 使用
// 在 ViewController 中点击按钮事件要执行网络请求
/** 登录按钮使能状态 */
@property (nonatomic, strong) RACSignal *loginBtnEnableSignal;
/** 登录按钮命令 执行这个命令时, 去执行网络请求 */
@property (nonatomic, strong)  RACCommand *loginCommand;

@end
