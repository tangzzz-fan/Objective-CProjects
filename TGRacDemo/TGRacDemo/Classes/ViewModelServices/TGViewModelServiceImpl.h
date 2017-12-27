//
//  TGFlickrSearchServiceImplement.h
//  TGRacDemo
//
//  Created by MacPro on 2017/12/27.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TGViewModelService.h"

@interface TGViewModelServiceImpl : NSObject<TGViewModelService>

// 对外提供一个根据 navigationController 创建总线服务的方式
- (instancetype)initWithNavigationController:(UINavigationController *)navigationController;

@end
