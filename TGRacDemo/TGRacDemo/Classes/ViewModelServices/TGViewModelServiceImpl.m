//
//  TGFlickrSearchServiceImplement.m
//  TGRacDemo
//
//  Created by MacPro on 2017/12/27.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "TGViewModelServiceImpl.h"
#import "TGFlickrSearchImpl.h"

@interface TGViewModelServiceImpl()

// 返回一个 flickrSerarch 服务
@property (strong, nonatomic) TGFlickrSearchImpl *searchService;
@property (weak, nonatomic) UINavigationController *navigationController;

@end

@implementation TGViewModelServiceImpl
#pragma mark - TGFlickrSearchService

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController {
    if (self = [super init]) {
        _searchService = [TGFlickrSearchImpl new];
        _navigationController = navigationController;
    }
    return self;
}

// 实现控制器对应的跳转
// 这里可以通过定义一个基类, 参数为 __kindof 识别
- (void)pushViewModel:(id)viewModel {
    // 判断 viewModel 的类型, 创建对应的 viewController. 让 viewController  进行跳转
    // 总体思路就是: 根据 viewModel 类型, 创建 viewController(这里使用 router 实现 viewModel 和 viewController 的跳转映射, 不需要 if 判断)
    // 最后执行 navigationController 跳转
}

/** 获取搜索服务 */
- (id<TGFlickrSearch>)getFlickrSearchService {
    return self.searchService;
}

@end
