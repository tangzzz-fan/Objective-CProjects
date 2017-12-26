//
//  TGSectionDelegate.m
//  TGTestKit
//
//  Created by MacPro on 2017/12/25.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "TGSectionDelegate.h"

@implementation TGSectionDelegate
@synthesize childDelegates = _childDelegates;
@synthesize propagationMode = _propagationMode;

#pragma mark - PrivateFunction
- (instancetype)initWithIndex:(NSInteger)index ChildDelegates:(NSMutableArray *)childDelegates {
    if (self = [super init]) {
        self.index = index;
        self.childDelegates = childDelegates;
        self.propagationMode = row;
    }
    return self;
}

- (void)prepareForTableView:(UITableView *)tableView {
    [super prepareForTableView:tableView];
    self.currentTableView = tableView;
}

- (void)reloadCurrentTableView {
    switch (self.reloadModeOnChildDelegatesChanged) {
        case Rwhole: {
            [self.currentTableView reloadData];
            break;
        }
        case Rsection: {
            NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:self.index];
            [self.currentTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
        }
        case Rnone: {
            break;
        }
        default:
            break;
    }
}


#pragma mark - Setter && Getter
- (void)setPropagationMode:(PropagationMode)propagationMode {
    if (self.propagationMode != row) {
        self.propagationMode = row;
    }
}

- (void)setChildDelegates:(NSMutableArray *)childDelegates {
    _childDelegates = childDelegates;
    [self reloadCurrentTableView];
}

@end
