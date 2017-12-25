//
//  TGBaseObject.h
//  TGTestProtocol
//
//  Created by MacPro on 2017/12/22.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TGBaseProtocol.h"

@interface TGBaseObject : NSObject

// 子类必须实现
- (instancetype)initWithIndex:(NSInteger)index ChildDelegates:(NSMutableArray<id<TGBaseProtocol>> *)childDelegates TableView:(UITableView *)tableView;

- (void)objectName;
@end
