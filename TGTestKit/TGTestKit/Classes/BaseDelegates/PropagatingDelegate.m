//
//  PropagatingDelegate.m
//  TGTestKit
//
//  Created by MacPro on 2017/12/25.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "PropagatingDelegate.h"


@interface PropagatingDelegate()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation PropagatingDelegate

@synthesize childDelegates = _childDelegates;

- (instancetype)initWithIndex:(NSInteger)index ChildDelegates:(NSMutableArray *)childDelegates PropagationMode:(PropagationMode )propagationMode {
    if (self = [super initWithIndex:index ChildDelegates:childDelegates]) {
        self.index = index;
        self.childDelegates = childDelegates;
        self.propagationMode = propagationMode;
        [self validateChildDelegates];
    }
    return self;
}

#pragma mark - Private Functions

/** 根据 indexPath 获取对应的索引 */
- (NSInteger)getValidChildIndex:(NSIndexPath *)indexpath {
    NSInteger childIndex = 0;
    if (self.propagationMode == row) { // 行方式
        childIndex = indexpath.row;
    } else if (self.parentDelegate == section) {
        childIndex = indexpath.section;
    }
    
    // 检查是否是有效的索引值
    if ((childIndex >= 0) && (childIndex < self.childDelegates.count)) {
        return childIndex;
    } else {
        return 0;
    }

}

/** 验证是否使用 section 方法 */
- (BOOL)isSectionMothodAllowedSectionIndex:(NSInteger)sectionIndex {
    NSInteger vailedIndex = 0;
    if (sectionIndex >= 0 && sectionIndex < self.childDelegates.count) {
        return vailedIndex && (self.propagationMode == section);
    }
    return NO;
}

#pragma mark - Delegate
#pragma mark TGBaseDelegate
- (void)prepareForTableView:(UITableView *)tableView {
    [self.childDelegates enumerateObjectsUsingBlock:^(TGBaseDelegate *child, NSUInteger idx, BOOL * _Nonnull stop) {
        [child prepareForTableView:tableView];
    }];
}

#pragma mark - DataSource
#pragma mark UITableViewDataSourc
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.propagationMode == row) { // 行管理
        return self.childDelegates.count;
    }
    
    for (TGBaseDelegate *childDelegate in self.childDelegates) {
        if (childDelegate.index != section) {
            continue;
        }
        return [childDelegate tableView:tableView numberOfRowsInSection:section];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL vaildSectionMode = ((self.propagationMode == section) && (indexPath.section < self.childDelegates.count));
    
    BOOL validRowMode = ((self.propagationMode == row)&&(indexPath.row < self.childDelegates.count));
    if (vaildSectionMode) {
        NSInteger indexSection = indexPath.section;
        return [self.childDelegates[indexSection] tableView:tableView cellForRowAtIndexPath:indexPath];
        
    }
    
    if (validRowMode) {
        NSInteger indexRow = indexPath.row;
        return [self.childDelegates[indexRow] tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    
    return [UITableViewCell new];
}

// optional methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.propagationMode == section ? self.childDelegates.count : 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([self isSectionMothodAllowedSectionIndex:section]) {
        TGBaseDelegate *childDelegate = self.childDelegates[section];
        return [childDelegate tableView:tableView titleForHeaderInSection:section];
    } else {
        return nil;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if ([self isSectionMothodAllowedSectionIndex:section]) {
        return [self.childDelegates[section] tableView:tableView titleForFooterInSection:section];
    } else {
        return nil;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger childIndex = [self getValidChildIndex:indexPath];
    if (childIndex) {
        return [self.childDelegates[childIndex] tableView:tableView canEditRowAtIndexPath:indexPath];
    } else {
        return false;
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger childIndex = [self getValidChildIndex:indexPath];
    if (childIndex) {
        return [self.childDelegates[childIndex] tableView:tableView canMoveRowAtIndexPath:indexPath];
    } else {
        return false;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger childIndex = [self getValidChildIndex:indexPath];
    if (childIndex) {
        return [self.childDelegates[childIndex] tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    }
}

#pragma mark - Delegate
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger childIndex = [self getValidChildIndex:indexPath];
    if (childIndex) {
        [self.childDelegates[childIndex] tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if ([self isSectionMothodAllowedSectionIndex:section]) {
        [self.childDelegates[section] tableView:tableView willDisplayHeaderView:view forSection:section];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    if ([self isSectionMothodAllowedSectionIndex:section]) {
        [self.childDelegates[section] tableView:tableView willDisplayFooterView:view forSection:section];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self getValidChildIndex:indexPath]) {
        [self.childDelegates[[self getValidChildIndex:indexPath]] tableView:tableView didEndDisplayingCell:cell forRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    if ([self isSectionMothodAllowedSectionIndex:section]) {
        [self.childDelegates[section] tableView:tableView didEndDisplayingHeaderView:view forSection:section];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section {
    if ([self isSectionMothodAllowedSectionIndex:section]) {
        [self.childDelegates[section] tableView:tableView didEndDisplayingFooterView:view forSection:section];
    }
}

// Height Suppoort
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self getValidChildIndex:indexPath]) {
        return [self.childDelegates[[self getValidChildIndex:indexPath]] tableView:tableView heightForRowAtIndexPath:indexPath];
    } else {
        return UITableViewAutomaticDimension;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([self isSectionMothodAllowedSectionIndex:section]) {
        return [self.childDelegates[section] tableView:tableView heightForHeaderInSection:section];
    } else {
        return 0.0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if ([self isSectionMothodAllowedSectionIndex:section]) {
        return [self.childDelegates[section] tableView:tableView heightForFooterInSection:section];
    } else {
        return 0.0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self getValidChildIndex:indexPath]) {
        return [self.childDelegates[[self getValidChildIndex:indexPath]] tableView:tableView estimatedHeightForRowAtIndexPath:indexPath];
    } else {
        return UITableViewAutomaticDimension;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    if ([self isSectionMothodAllowedSectionIndex:section]) {
        return [self.childDelegates[section] tableView:tableView estimatedHeightForHeaderInSection:section];
    } else {
        return 0.0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
    if ([self isSectionMothodAllowedSectionIndex:section]) {
        return [self.childDelegates[section] tableView:tableView estimatedHeightForFooterInSection:section];
    } else {
        return 0.0;
    }
}

// Header && Footer View
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([self isSectionMothodAllowedSectionIndex:section]) {
        return [self.childDelegates[section] tableView:tableView viewForHeaderInSection:section];
    } else {
        return nil;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if ([self isSectionMothodAllowedSectionIndex:section]) {
        return [self.childDelegates[section] tableView:tableView viewForFooterInSection:section];
    } else {
        return nil;
    }
}

// Editing
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [self getValidChildIndex:indexPath];
    if (index) {
        return [self.childDelegates[index] tableView:tableView editingStyleForRowAtIndexPath:indexPath];
    } else {
        return UITableViewCellEditingStyleNone;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [self getValidChildIndex:indexPath];
    if (index ) {
        return [self.childDelegates[index] tableView:tableView titleForDeleteConfirmationButtonForRowAtIndexPath:indexPath];
    } else {
        return nil;
    }
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [self getValidChildIndex:indexPath];
    if (index) {
        return [self.childDelegates[index] tableView:tableView editActionsForRowAtIndexPath:indexPath];
    } else {
        return nil;
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [self getValidChildIndex:indexPath];
    if (index) {
        return [self.childDelegates[index] tableView:tableView shouldIndentWhileEditingRowAtIndexPath:indexPath];
    } else {
        return NO;
    }
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [self getValidChildIndex:indexPath];
    if (index) {
        return [self.childDelegates[index] tableView:tableView willBeginEditingRowAtIndexPath:indexPath];
        
    }
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [self getValidChildIndex:indexPath];
    if (index) {
        [self tableView:tableView didEndEditingRowAtIndexPath:indexPath];
    }
}

// Selection
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [self getValidChildIndex:indexPath];
    if (index) {
        [self.childDelegates[index] tableView:tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [self getValidChildIndex:indexPath];
    if (index) {
        return [self.childDelegates[index] tableView:tableView shouldHighlightRowAtIndexPath:indexPath];
    } else {
        return NO;
    }
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [self getValidChildIndex:indexPath];
    if (index) {
        [self.childDelegates[index] tableView:tableView didHighlightRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [self getValidChildIndex:indexPath];
    if (index) {
        [self.childDelegates[index] tableView:tableView didUnhighlightRowAtIndexPath:indexPath];
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger validIndex = [self getValidChildIndex:indexPath];
    if (validIndex) {
        SEL expectedSelector = @selector(tableView:willSelectRowAtIndexPath:);
        TGBaseDelegate *expectedDelegate = self.childDelegates[validIndex];
        
        if ([expectedDelegate respondsToSelector:expectedSelector]) {
            return [expectedDelegate tableView:tableView willSelectRowAtIndexPath:indexPath];
        } else {
            return indexPath;
        }
        
    } else {
        return indexPath;
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger validIndex = [self getValidChildIndex:indexPath];

    if (validIndex) {
        SEL expectedSelector = @selector(tableView:willDeselectRowAtIndexPath:);
        TGBaseDelegate *expectedDelegate = self.childDelegates[validIndex];
        
        if ([expectedDelegate respondsToSelector:expectedSelector]) {
            return [expectedDelegate tableView:tableView willSelectRowAtIndexPath:indexPath];
        } else {
            return indexPath;
        }
        
    } else {
        return indexPath;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [self getValidChildIndex:indexPath];
    if (index) {
        [self.childDelegates[index] tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [self getValidChildIndex:indexPath];
    if (index) {
        [self.childDelegates[index] tableView:tableView didDeselectRowAtIndexPath:indexPath];
    }
}

// Copy&&Paste
- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [self getValidChildIndex:indexPath];
    if (index) {
        return [self.childDelegates[index] tableView:tableView shouldShowMenuForRowAtIndexPath:indexPath];
    } else {
        return false;
    }
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    NSInteger index = [self getValidChildIndex:indexPath];
    if (index) {
        return [self.childDelegates[index] tableView:tableView canPerformAction:action forRowAtIndexPath:indexPath withSender:sender];
    } else {
        return false;
    }
}

- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    NSInteger index = [self getValidChildIndex:indexPath];
    if (index) {
        [self.childDelegates[index] tableView:tableView performAction:action forRowAtIndexPath:indexPath withSender:sender];
    }
}

// Focus
- (BOOL)tableView:(UITableView *)tableView canFocusRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [self getValidChildIndex:indexPath];
    if (index) {
        return [self.childDelegates[index] tableView:tableView canFocusRowAtIndexPath:indexPath];
    } else {
        return false;
    }
}

// Reorder
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [self getValidChildIndex:indexPath];
    if (index) {
        return  [self.childDelegates[index] tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
    } else {
        return 0;
    }
}

#pragma mark - Setter&&Getter
- (void)setChildDelegates:(NSMutableArray *)childDelegates {
    _childDelegates = childDelegates;
    [self validateChildDelegates];
}


@end
