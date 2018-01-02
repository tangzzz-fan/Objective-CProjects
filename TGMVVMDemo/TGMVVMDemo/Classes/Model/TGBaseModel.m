//
//  TGBaseModel.m
//  TGMVVMDemo
//
//  Created by MacPro on 2018/1/2.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import "TGBaseModel.h"
@interface TGBaseModel()

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger index;


@end
@implementation TGBaseModel
- (instancetype)initWithName:(NSString *)name index:(NSInteger)index description:(NSString *)desc {
    if (self = [super init]) {
        self.name = name;
        self.index = index;
        self.desc = desc;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"This is a %@ description %@ -- index : %zd -- desc : %@", [self class], self.name, self.index, self.desc];
}
@end
