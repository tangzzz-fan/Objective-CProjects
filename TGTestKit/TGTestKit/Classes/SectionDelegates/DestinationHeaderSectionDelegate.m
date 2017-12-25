//
//  DestinationHeaderSectionDelegate.m
//  TGTestKit
//
//  Created by MacPro on 2017/12/22.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "DestinationHeaderSectionDelegate.h"

#import "DestinationHeaderCell.h"

@interface DestinationHeaderSectionDelegate()
@end

@implementation DestinationHeaderSectionDelegate

#pragma mark - LifeCycle
- (instancetype)initWithIndex:(NSInteger)index ChildDelegates:(NSArray <id<CascadingTableDelegate>>*)childDelegates {
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark - Function
- (void)initData {
    self.rowDict = @{@"0":@"first", @"1":@"second", @"2":@"third"}.mutableCopy;
}

#pragma mark - Action
#pragma mark - Delegate
#pragma mark CascadingTableDelegate
// 执行 tableView 的初始化方法
- (void)prepareForTableView:(UITableView *)tableView {
    self.currentTableView = tableView;
    // 注册 cell
    [self registerCellForTableView:tableView];
}


#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.rowDict[@(indexPath.row)] != nil) {
        return [self getPreferedHeightForRow:indexPath.row];
    } else {
        return 0;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1.1;
}


#pragma mark - DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rowDict.allKeys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 当需要渲染时, 检查这一组的 cell 在传递进来的 tableView 中的位置,如果相同, 就去缓冲池中找, 如果没有, 就直接返回一个新的
    if (self.rowDict[@(indexPath.row)] != nil) {
        return [tableView dequeueReusableCellWithIdentifier:self.rowDict[@(indexPath.row)] forIndexPath:indexPath];
    } else {
        return [[UITableViewCell alloc] init];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.rowDict[@(indexPath.row)] == nil) {
        return;
    }
    // 根据 cell row 的不同, 执行对应的 cell 的配置: 获取 cell 的类型, 然后执行对应的操作
    
}

#pragma mark - Notification
#pragma mark - PrivateFunction
- (void)registerCellForTableView:(UITableView *)tableView {
    [self.rowDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, NSString *identifier, BOOL * _Nonnull stop) {
        UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:identifier];
    }];
}

- (CGFloat)getPreferedHeightForRow:(NSInteger)row {
    switch (row) {
        case 0:
            return [DestinationHeaderCell preferedHeight];
            break;
        case 1:
            return [DestinationHeaderCell preferedHeight];
            break;
        case 2:
            return [DestinationHeaderCell preferedHeight];
            break;
            
        default:
            return 0;
            break;
    }
    return 0;
}
#pragma mark - Setter && Getter
// 根据所在的行, 调用 cell 执行对应的方法注册
// 比如第一行是: mapCell. 调用 mapCell.registerIdentifier
- (void)setRowDict:(NSMutableDictionary *)rowDict {
    _rowDict = rowDict;
    [rowDict.allKeys enumerateObjectsUsingBlock:^(NSString *index, NSUInteger idx, BOOL * _Nonnull stop) {
        switch (index.integerValue) {
            case 0:
                // 第一行
                rowDict[@"0"] = @"this is first";
                break;
            case 1:
                // 第二行
                rowDict[@"1"] = @"this is second";

                break;
            case 2:
                // 第三行
                rowDict[@"2"] = @"this is third";

                break;
                
            default:
                break;
        }
    }];
}
@end
