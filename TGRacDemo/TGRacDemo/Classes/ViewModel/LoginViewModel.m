//
//  LoginViewModel.m
//  TGRacDemo
//
//  Created by 汤振治 on 26/12/2017.
//  Copyright © 2017 Centaline. All rights reserved.
//

#import "LoginViewModel.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

#import <SVProgressHUD.h>

@implementation LoginViewModel
- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    // 创建登录按钮信号
    // 根据 username 和 password 的长度决定这个信号是否能发送数据给订阅者
    self.loginBtnEnableSignal = [RACSignal combineLatest:@[RACObserve(self, userName), RACObserve(self, password)] reduce:^id(NSString *userName, NSString *password){
        return @(userName.length > 6  && password.length > 6);
    }];
    
    // 使用一个信号创建一个 raccommand

    self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            // 创建网络请求
            // 这里也可以对应的使用分散式网络请求 对应的创建信号
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://120.25.226.186:32812/login"]];
            request.HTTPMethod = @"POST";
            NSString *paramString = [NSString stringWithFormat:@"username=%@&pwd=%@&type=JSON", self.userName, self.password];
            NSData *paramData = [paramString dataUsingEncoding:NSUTF8StringEncoding];
            request.HTTPBody = paramData;
            
            [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                NSDictionary *resultDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:NULL];
                [subscriber sendNext:resultDictionary];
                [subscriber sendCompleted];
            }] resume];
            
            return nil;
        }] replayLazily];
    }];
    
    // 观察按钮执行命令的状态
    // 订阅按钮执行信号的最新状态 来控制显示提示框, 错误处理
    [self.loginCommand.executionSignals.switchToLatest subscribeNext:^(NSDictionary *info) {
        if ([info.allKeys.lastObject isEqualToString:@"success"]) {
             [SVProgressHUD showSuccessWithStatus:@"登录成功"];
        } else {
            [SVProgressHUD showErrorWithStatus:@"登录失败"];
            [SVProgressHUD dismissWithDelay:1];
        }
    }];
    
    [[self.loginCommand.executing skip:1] subscribeNext:^(NSNumber *x) {
        NSLog(@"");
        if ([x boolValue]) {
            [SVProgressHUD showWithStatus:@"正在登录中..."];
        }
    }];
}
@end
