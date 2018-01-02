//
//  TGBaseViewModel.m
//  TGMVVMDemo
//
//  Created by MacPro on 2018/1/2.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import "TGBaseViewModel.h"

#import "TGBaseModel.h"

@interface TGBaseViewModel()

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger index;


@end

@implementation TGBaseViewModel
- (instancetype)initWithName:(NSString *)name index:(NSInteger)index {
    if (self = [super init]) {
        self.name = name;
        self.index = index;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"This is a %@ description %@ -- index : %zd", [self class], self.name, self.index];
}

- (NSString *)headerTitle {
    return [NSString stringWithFormat:@"Test %zd -- name %@", self.index, self.name];
}

- (NSMutableArray<TGBaseModel *> *)modelArray {
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
        for (NSInteger i = 0; i < self.index; i ++) {
            TGBaseModel *model = [[TGBaseModel alloc] initWithName:@"TestModel" index:self.index description:[NSString stringWithFormat:@"is from %@", [self class]]];
            [_modelArray addObject:model];
        }
    }
    return _modelArray;
}
@end
