//
//  TGScenicCellViewModel.h
//  TGMVVMDemo
//
//  Created by 汤振治 on 04/01/2018.
//  Copyright © 2018 Centaline. All rights reserved.
//  为 Scenic 业务定制使用的 ViewModel


#import "TGPOICellViewModel.h"

@class TGScenic;
@interface TGScenicCellViewModel : TGPOICellViewModel
/** 当前城市 ID */
@property (nonatomic, assign) NSInteger currentCityID;

// 提供使用 Model 创建 ViewModel 的方法
- (instancetype)initWithScenic:(TGScenic *)scenic;
@end
