//
//  Network.m
//  TGCacheDemo
//
//  Created by 汤振治 on 06/01/2018.
//  Copyright © 2018 Centaline. All rights reserved.
//

#import "Network.h"

@implementation Network
- (void)test {
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    
    [manager GET:@"http://localhost" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}
@end
