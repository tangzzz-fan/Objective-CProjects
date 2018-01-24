//
//  TGDemo5CellViewModel.h
//  TGMVVMDemo
//
//  Created by MacPro on 2018/1/24.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import "TGBaseCellViewModel.h"

@interface TGDemo5CellViewModel : TGBaseCellViewModel

@property (strong, nonatomic) NSDictionary *dict;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end
