//
//  TGFirstObject.h
//  TGTestProtocol
//
//  Created by MacPro on 2017/12/22.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "TGBaseObject.h"

@interface TGFirstObject : TGBaseObject

// required methods in superClass
- (instancetype)initWithIndex:(NSInteger)index ChildDelegates:(NSMutableArray<id<TGBaseProtocol>> *)childDelegates TableView:(UITableView *)tableView;


- (void)customName;
@end
