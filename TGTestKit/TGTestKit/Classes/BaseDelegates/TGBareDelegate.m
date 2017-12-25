//
//  TGBareDelegate.m
//  TGTestKit
//
//  Created by MacPro on 2017/12/25.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "TGBareDelegate.h"

@implementation TGBareDelegate
- (void)prepareForTableView:(UITableView *)tableView {
    [self.childDelegates enumerateObjectsUsingBlock:^(TGBaseDelegate *child, NSUInteger idx, BOOL * _Nonnull stop) {
        [child prepareForTableView:tableView];
    }];
}

#pragma mark - Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UITableViewCell new];
}

@end
