//
//  TGViewModelService.h
//  TGRacDemo
//
//  Created by MacPro on 2017/12/27.
//  Copyright © 2017年 Centaline. All rights reserved.
//  MVVM 中使用的全局总线(一个协议)

#import <CoreFoundation/CoreFoundation.h>
#import "TGFlickrSearch.h"

@protocol TGViewModelService<NSObject>
// 对应 view 层的 pushViewController
- (void)pushViewModel:(id)viewModel;

// 获取搜索服务
- (id<TGFlickrSearch>)getFlickrSearchService;

@end
