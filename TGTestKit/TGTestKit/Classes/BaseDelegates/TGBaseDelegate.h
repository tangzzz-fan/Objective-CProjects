//
//  TGBaseDelegate.h
//  TGTestKit
//
//  Created by MacPro on 2017/12/25.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TGBaseDelegate : NSObject<UITableViewDelegate, UITableViewDataSource>
// 必须要实现的
@property (assign, nonatomic) NSInteger index;
@property (strong, nonatomic) NSMutableArray *childDelegates;
@property (weak, nonatomic) TGBaseDelegate *parentDelegate;


- (instancetype)initWithIndex:(NSInteger)index ChildDelegates:(NSMutableArray *)childDelegates;
- (instancetype)initWithIndex:(NSInteger)index ChildDelegates:(NSMutableArray *)childDelegates TableView:(UITableView *)tableView;

- (void)prepareForTableView:(UITableView *)tableView;
- (void)validateChildDelegates;

@end
