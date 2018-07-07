//
//  ZFIndexDefaultRecEstatesApi.m
//  findproperty
//
//  Created by MacPro on 2018/6/21.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import "ZFIndexDefaultRecEstatesApi.h"
#import <MJExtension.h>

@interface ZFIndexDefaultRecEstatesApi()
@property (copy, nonatomic) NSString *postTypeStr;

@end

@implementation ZFIndexDefaultRecEstatesApi

- (instancetype)init {
    if (self = [super init]) {
        [self customInit];
    }
    return self;
}

- (void)customInit {
    
    
    //设置可接受的数据类型
    YTKNetworkAgent *agent = [YTKNetworkAgent sharedAgent];
    
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.debugLogEnabled = YES;
    config.baseUrl = @"http://10.4.99.40:88/apushzfapi_021new/json/reply/";
    
    NSSet *acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", @"text/css", nil];
    NSString *keypath = @"jsonResponseSerializer.acceptableContentTypes";
    [agent setValue:acceptableContentTypes forKeyPath:keypath];
}

- (instancetype)initWithPostType:(NSString *)postTypeStr {
    if (self = [super init]) {
        self.postTypeStr = postTypeStr;
    }
    return self;
}

- (NSURLRequest *)buildCustomUrlRequest {
    

    NSDictionary *dict = @{
                           @"BaseRequest" :@{
                                   @"PostType":@"S",
                                   @"ImageWidth":@(640),
                                   @"ImageHeight":@(640),
                                   @"PageIndex":@(0),
                                   @"PageCount":@10,
                                   } ,
                           @"Lat":@(31.22127882013799),
                           @"Lng":@(121.4390584755353),
                           @"Round":@(3000)
                           };
    NSString *str = dict.mj_JSONString;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[@"http://10.4.99.40:88/apushzfapi_021new/json/reply/GetGEOPostsRequest" stringByAppendingString:self.requestUrl]]];
    [request addValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    // 使用 NSData 包装
    [request setHTTPBody:[str dataUsingEncoding:NSUTF8StringEncoding]];
    
    return request;
}

- (NSString *)requestUrl {
    return @"GetGeoPostsRequest";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}


// 1 获取本地经纬度,获取 3km 内对应房源
// 2 没有经纬度, 获取默认房源
- (id)requestArgument {
    
    return @{
             @"BaseRequest" :@{
                     @"PostType":@"S",
                     @"ImageWidth":@(640),
                     @"ImageHeight":@(640),
                     @"PageIndex":@(0),
                     @"PageCount":@10,
                     } ,
             @"Lat":@(31.22127882013799),
             @"Lng":@(121.4390584755353),
             @"Round":@(3000)
             };

}

@end

