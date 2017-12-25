//
//  TGBaseDelegate.m
//  TGTestKit
//
//  Created by MacPro on 2017/12/25.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "TGBaseDelegate.h"

@interface TGBaseDelegate()

@end
@implementation TGBaseDelegate

// 基类中简单实现
- (instancetype)initWithIndex:(NSInteger)index ChildDelegates:(NSMutableArray *)childDelegates {
    if ([super init]) {
        self.index = index;
        self.childDelegates = childDelegates;
    }
    return self;
}

// 通过协议扩展声明的方法在这里必须实现
- (instancetype)initWithIndex:(NSInteger)index ChildDelegates:(NSMutableArray *)childDelegates TableView:(UITableView *)tableView {
    if (self = [self initWithIndex:index ChildDelegates:childDelegates]) {
        [self validateChildDelegates];
        [childDelegates enumerateObjectsUsingBlock:^(TGBaseDelegate *child, NSUInteger idx, BOOL * _Nonnull stop) {
            [child prepareForTableView:tableView];
        }];
        tableView.delegate = self;
        tableView.dataSource = self;
    }
    return self;
}

#pragma mark - PrivateFunctions
// 验证子代理
- (void)validateChildDelegates {
    [self.childDelegates enumerateObjectsUsingBlock:^(TGBaseDelegate *child, NSUInteger idx, BOOL * _Nonnull stop) {
        child.index = idx;
        child.parentDelegate = self;
    }];
}

#pragma mark - Setter&&Getter


@end
