//
//  TGBaseViewModel.m
//  TGMVVMDemo
//
//  Created by MacPro on 2018/1/2.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import "TGBaseViewModel.h"
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
    return [NSString stringWithFormat:@"this is a %@ description %@ -- index : %zd", [self class], self.name, self.index];
}
@end
