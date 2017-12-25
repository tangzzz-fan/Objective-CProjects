//
//  TGFirstObject.m
//  TGTestProtocol
//
//  Created by MacPro on 2017/12/22.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "TGFirstObject.h"

@implementation TGFirstObject
- (instancetype)initWithIndex:(NSInteger)index ChildDelegates:(NSMutableArray<id<TGBaseProtocol>> *)childDelegates TableView:(UITableView *)tableView {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)customName {
    NSLog(@"this is my custom name %@", [self class]);
}
@end
