//
//  UITableViewDelegateAndDataSourceImplementationProxy.m
//  GCExtension
//
//  Created by njgarychow on 10/14/14.
//  Copyright (c) 2014 zhoujinqiang. All rights reserved.
//

#import "UITableViewDelegateAndDataSourceImplementationProxy.h"

#import "UITableView+GCDelegateAndDataSourceBlock.h"

@interface UITableViewDelegateAndDataSourceImplementation : UIScrollViewDelegateImplementation <UITableViewDelegate, UITableViewDataSource>

@end

@implementation UITableViewDelegateAndDataSourceImplementation

#pragma mark - UITableView Datasource method

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.blockForRowCell(tableView, indexPath);
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return tableView.blockForSectionNumber(tableView);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableView.blockForRowNumber(tableView, (int)section);
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return tableView.blockForSectionIndexTitles(tableView);
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return tableView.blockForSectionIndex(tableView, title, (int)index);
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return tableView.blockForFooterTitle(tableView, (int)section);
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return tableView.blockForHeaderTitle(tableView, (int)section);
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.blockForRowCommitEditStyleForRow(tableView, editingStyle, indexPath);
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.blockForRowCanEditRow(tableView, indexPath);
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.blockForRowCanMoveRow(tableView, indexPath);
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    tableView.blockForRowMove(tableView, sourceIndexPath, destinationIndexPath);
}

#pragma mark - UITableView Delegate method

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.blockForRowHeight(tableView, indexPath);
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.blockForRowEstimatedHeight(tableView, indexPath);
}
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.blockForRowIndentationLevel(tableView, indexPath);
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.blockForRowCellWillDisplay(tableView, cell, indexPath);
}
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.blockForRowEditActions(tableView, indexPath);
}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    tableView.blockForRowAccessoryButtonTapped(tableView, indexPath);
}
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.blockForRowWillSelect(tableView, indexPath);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.blockForRowDidSelect(tableView, indexPath);
}
- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.blockForRowWillDeselect(tableView, indexPath);
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.blockForRowDidDeselecte(tableView, indexPath);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return tableView.blockForHeaderView(tableView, (int)section);
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return tableView.blockForFooterView(tableView, (int)section);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return tableView.blockForHeaderHeight(tableView, (int)section);
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    return tableView.blockForHeaderEstimatedHeight(tableView, (int)section);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return tableView.blockForFooterHeight(tableView, (int)section);
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
    return tableView.blockForFooterEstimatedHeight(tableView, (int)section);
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    tableView.blockForHeaderViewWillDisplay(tableView, view, (int)section);
}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    tableView.blockForFooterViewWillDisplay(tableView, view, (int)section);
}
- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.blockForRowWillBeginEditing(tableView, indexPath);
}
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.blockForRowDidEndEditing(tableView, indexPath);
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.blockForRowEditingStyle(tableView, indexPath);
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.blockForRowDeleteConfirmationButtonTitle(tableView, indexPath);
}
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.blockForRowShouldIndentWhileEditing(tableView, indexPath);
}
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    return tableView.blockForRowMoveTargetIndexPath(tableView, sourceIndexPath, proposedDestinationIndexPath);
}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.blockForRowDidEndDisplayingCell(tableView, cell, indexPath);
}
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    tableView.blockForHeaderViewDidEndDisplaying(tableView, view, (int)section);
}
- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section {
    tableView.blockForFooterViewDidEndDisplaying(tableView, view, (int)section);
}
- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.blockForRowShouldShowMenu(tableView, indexPath);
}
- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    return tableView.blockForRowCanPerformAction(tableView, action, indexPath, sender);
}
- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    tableView.blockForRowPerformAction(tableView, action, indexPath, sender);
}
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.blockForRowShouldHighlight(tableView, indexPath);
}
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.blockForRowDidHighlight(tableView, indexPath);
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.blockForRowDidUnhighlight(tableView, indexPath);
}

@end




@interface UITableViewDelegateAndDataSourceImplementationProxy ()

@property (nonatomic, strong) UITableViewDelegateAndDataSourceImplementation* realObject;

@end

@implementation UITableViewDelegateAndDataSourceImplementationProxy

- (instancetype)init {
    _realObject = [[UITableViewDelegateAndDataSourceImplementation alloc] init];
    return self;
}

#define BlockStatementTest(statement) do { if (statement) { return YES; } } while (0)
#define Statement(selectorString, block) (block && [selectorString isEqualToString:targetSelectorString])
#define BlockStatement(block, selectorString) BlockStatementTest(Statement(selectorString, block))

- (BOOL)respondsToSelector:(SEL)aSelector {
    NSString* targetSelectorString = NSStringFromSelector(aSelector);
    
    /**
     *  BlcokStatement expand:
     *  if (|block| && [|selectorString| isEqualToString:targetSelectorString]) {
     *      return YES;
     *  }
     */
    BlockStatement(self.owner.blockForRowCell, @"tableView:cellForRowAtIndexPath:");
    BlockStatement(self.owner.blockForSectionNumber, @"numberOfSectionsInTableView:");
    BlockStatement(self.owner.blockForRowNumber, @"tableView:numberOfRowsInSection:");
    BlockStatement(self.owner.blockForSectionIndexTitles, @"sectionIndexTitlesForTableView:");
    BlockStatement(self.owner.blockForSectionIndex, @"tableView:sectionForSectionIndexTitle:atIndex:");
    BlockStatement(self.owner.blockForFooterTitle, @"tableView:titleForFooterInSection:");
    BlockStatement(self.owner.blockForHeaderHeight, @"tableView:titleForHeaderInSection:");
    BlockStatement(self.owner.blockForRowCommitEditStyleForRow, @"tableView:commitEditingStyle:forRowAtIndexPath:");
    BlockStatement(self.owner.blockForRowCanEditRow, @"tableView:canEditRowAtIndexPath:");
    BlockStatement(self.owner.blockForRowCanMoveRow, @"tableView:canMoveRowAtIndexPath:");
    BlockStatement(self.owner.blockForRowMove, @"tableView:moveRowAtIndexPath:toIndexPath:");
    
    BlockStatement(self.owner.blockForRowHeight, @"tableView:heightForRowAtIndexPath:");
    BlockStatement(self.owner.blockForRowEstimatedHeight, @"tableView:estimatedHeightForRowAtIndexPath:");
    BlockStatement(self.owner.blockForRowIndentationLevel, @"tableView:indentationLevelForRowAtIndexPath:");
    BlockStatement(self.owner.blockForRowCellWillDisplay, @"tableView:willDisplayCell:forRowAtIndexPath:");
    BlockStatement(self.owner.blockForRowEditActions, @"tableView:editActionsForRowAtIndexPath:");
    BlockStatement(self.owner.blockForRowAccessoryButtonTapped, @"tableView:accessoryButtonTappedForRowWithIndexPath:");
    BlockStatement(self.owner.blockForRowWillSelect, @"tableView:willSelectRowAtIndexPath:");
    BlockStatement(self.owner.blockForRowDidSelect, @"tableView:didSelectRowAtIndexPath:");
    BlockStatement(self.owner.blockForRowWillDeselect, @"tableView:willDeselectRowAtIndexPath:");
    BlockStatement(self.owner.blockForRowDidDeselecte, @"tableView:didDeselectRowAtIndexPath:");
    BlockStatement(self.owner.blockForHeaderView, @"tableView:viewForHeaderInSection:");
    BlockStatement(self.owner.blockForFooterView, @"tableView:viewForFooterInSection:");
    BlockStatement(self.owner.blockForHeaderHeight, @"tableView:heightForHeaderInSection:");
    BlockStatement(self.owner.blockForHeaderEstimatedHeight, @"tableView:estimatedHeightForHeaderInSection:");
    BlockStatement(self.owner.blockForFooterHeight, @"tableView:heightForFooterInSection:");
    BlockStatement(self.owner.blockForFooterEstimatedHeight, @"tableView:estimatedHeightForFooterInSection:");
    BlockStatement(self.owner.blockForHeaderViewWillDisplay, @"tableView:willDisplayHeaderView:forSection:");
    BlockStatement(self.owner.blockForFooterViewWillDisplay, @"tableView:willDisplayFooterView:forSection:");
    BlockStatement(self.owner.blockForRowWillBeginEditing, @"tableView:willBeginEditingRowAtIndexPath:");
    BlockStatement(self.owner.blockForRowDidEndEditing, @"tableView:didEndEditingRowAtIndexPath:");
    BlockStatement(self.owner.blockForRowEditingStyle, @"tableView:editingStyleForRowAtIndexPath:");
    BlockStatement(self.owner.blockForRowDeleteConfirmationButtonTitle, @"tableView:titleForDeleteConfirmationButtonForRowAtIndexPath:");
    BlockStatement(self.owner.blockForRowShouldIndentWhileEditing, @"tableView:shouldIndentWhileEditingRowAtIndexPath:");
    BlockStatement(self.owner.blockForRowMoveTargetIndexPath, @"tableView:targetIndexPathForMoveFromRowAtIndexPath:toProposedIndexPath:");
    BlockStatement(self.owner.blockForRowDidEndDisplayingCell, @"tableView:didEndDisplayingCell:forRowAtIndexPath:");
    BlockStatement(self.owner.blockForHeaderViewDidEndDisplaying, @"tableView:didEndDisplayingHeaderView:forSection:");
    BlockStatement(self.owner.blockForFooterViewDidEndDisplaying, @"tableView:didEndDisplayingFooterView:forSection:");
    BlockStatement(self.owner.blockForRowShouldShowMenu, @"tableView:shouldShowMenuForRowAtIndexPath:");
    BlockStatement(self.owner.blockForRowCanPerformAction, @"tableView:canPerformAction:forRowAtIndexPath:withSender:");
    BlockStatement(self.owner.blockForRowPerformAction, @"tableView:performAction:forRowAtIndexPath:withSender:");
    BlockStatement(self.owner.blockForRowShouldHighlight, @"tableView:shouldHighlightRowAtIndexPath:");
    BlockStatement(self.owner.blockForRowDidHighlight, @"tableView:didHighlightRowAtIndexPath:");
    BlockStatement(self.owner.blockForRowDidUnhighlight, @"tableView:didUnhighlightRowAtIndexPath:");
    
    return [super respondsToSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [_realObject methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:_realObject];
}

- (void)dealloc {
    if (self == self.owner.delegate) {
        self.owner.delegate = nil;
    }
    if (self == self.owner.dataSource) {
        self.owner.dataSource = nil;
    }
}

@end