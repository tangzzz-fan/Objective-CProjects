//
//  TGDemo5CellViewModel.m
//  TGMVVMDemo
//
//  Created by MacPro on 2018/1/24.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import "TGDemo5CellViewModel.h"

@interface TGDemo5CellViewModel()

@end

@implementation TGDemo5CellViewModel
- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.dict = dict;
    }
    return self;
}
@end
