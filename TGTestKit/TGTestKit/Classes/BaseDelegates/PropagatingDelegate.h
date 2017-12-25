//
//  PropagatingDelegate.h
//  TGTestKit
//
//  Created by MacPro on 2017/12/25.
//  Copyright © 2017年 Centaline. All rights reserved.
//  确定组类型, 行类型

#import "TGBaseDelegate.h"

typedef enum : NSUInteger {
    section = 0,
    row
} PropagationMode;

@interface PropagatingDelegate : TGBaseDelegate
// 定义一个枚举类型, 表示是行类型 还是 组类型
@property (assign, nonatomic) PropagationMode propagationMode;

@property (assign, nonatomic) NSInteger index;

@property (strong, nonatomic) NSMutableArray *childDelegates;

@property (weak, nonatomic) TGBaseDelegate *parentDelegate;

- (instancetype)initWithIndex:(NSInteger)index ChildDelegates:(NSMutableArray *)childDelegates PropagationMode:(PropagationMode )propagationMode;
@end
