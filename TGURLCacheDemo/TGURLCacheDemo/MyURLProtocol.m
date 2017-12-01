//
//  MyURLProtocol.m
//  TGURLCacheDemo
//
//  Created by MacPro on 2017/11/30.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "MyURLProtocol.h"

@implementation MyURLProtocol
#pragma mark - URLProtocol 的类方法实现

// 是否处理对应的请求
+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    if (request) {
        return YES;
    } else {
        return NO;
    }
}

// 返回请求, 在此方法中可以修改请求
+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    NSURLRequest *newRequest = request;
    
    // 域名为执行 ip. 实际开发中为服务器下方的 domain list
    NSString *originHostStr = request.URL.host;
    // 找到 baidu.com 就进行对应的域名替换
    if ([originHostStr isEqualToString:@"baidu.com"]) {
        NSString *originURLStr = request.URL.host;
        NSString *newURLStr = [originURLStr stringByReplacingOccurrencesOfString:originHostStr withString:@""];
        [newRequest setValue:[NSURL URLWithString:newURLStr] forKey:@"URL"];
    }
    
    return newRequest;
}


// 开始加载
- (void)startLoading {
    // 获取 request
    
}
@end
