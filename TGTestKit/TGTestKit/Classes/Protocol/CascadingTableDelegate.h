//
//  CascadingTableDelegate.h
//  TGTestKit
//
//  Created by MacPro on 2017/12/22.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "ProtocolKit.h"

@protocol CascadingTableDelegate <NSObject, UITableViewDataSource, UITableViewDelegate>

@property (assign, nonatomic) NSInteger index;
@property (strong, nonatomic) NSArray<id<CascadingTableDelegate>> *childDelegates;

@property (weak, nonatomic) id<CascadingTableDelegate> parentDelegate;

- (instancetype)initWithIndex:(NSInteger)index ChildDelegates:(NSArray<id<CascadingTableDelegate>> *)childDelegates;
- (void)prepareForTableView:(UITableView *)tableView;
@end

//@defs(CascadingTableDelegate)
//- (instancetype)initWithIndex:(NSInteger)index ChildDelegates:(NSArray<id<CascadingTableDelegate>> *)childDelegates TableView:(UITableView *)tableView {
//    if (self = [self initWithIndex:index ChildDelegates:childDelegates]) {
//        [self validateChildDelegates];
//        if (tableView) {
//            [self.childDelegates enumerateObjectsUsingBlock:^(id<CascadingTableDelegate>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                [obj prepareForTableView:tableView];
//            }];
//            tableView.delegate = self;
//            tableView.dataSource = self;
//        }
//    }
//    return self;
//}
//
//- (void)validateChildDelegates {
//    [self.childDelegates enumerateObjectsUsingBlock:^(id<CascadingTableDelegate>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        obj.index = idx;
//        obj.parentDelegate = self;
//    }];
//}

//@end

