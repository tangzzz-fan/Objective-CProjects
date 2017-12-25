//
//  TGRootDelegate.m
//  TGTestKit
//
//  Created by MacPro on 2017/12/25.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "TGRootDelegate.h"

@implementation TGRootDelegate
@synthesize childDelegates = _childDelegates;
@synthesize propagationMode = _propagationMode;

- (instancetype)initWithIndex:(NSInteger)index ChildDelegates:(NSMutableArray *)childDelegates {
    if (self = [super init]) {
        self.index = index;
        self.childDelegates = childDelegates;
        self.propagationMode = section;
    }
    return self;
}

#pragma mark - Setter && Getter
- (PropagationMode)propagationMode {
    return _propagationMode;
}

- (void)setPropagationMode:(PropagationMode)propagationMode {
    if (self.propagationMode != section) {
        self.propagationMode = section;
    }
}

- (void)setChildDelegates:(NSMutableArray *)childDelegates {
    _childDelegates = childDelegates;
    if (self.reloadOnChildDelegateChanged) {
        [self.currentTableView reloadData];
    }
}

#pragma mark - Private Function
- (void)prepareForTableView:(UITableView *)tableView {
    [super prepareForTableView:tableView];
    tableView.dataSource = self;
    tableView.delegate = self;
    
    self.currentTableView = tableView;
}


@end
