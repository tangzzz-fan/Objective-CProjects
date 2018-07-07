//
//  ZFIndexDefaultRecEstatesApi.h
//  findproperty
//
//  Created by MacPro on 2018/6/21.
//  Copyright © 2018年 Centaline. All rights reserved.
//
#import "YTKNetwork.h"
#import "YTKRequest.h"

@interface ZFIndexDefaultRecEstatesApi : YTKRequest
- (instancetype)initWithPostType:(NSString *)postTypeStr;
@end
