//
//  UITableView+GCBlock.h
//  IPSShelf
//
//  Created by zhoujinqiang on 14-8-6.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *  This extension uses the catagory of the UITableView to implement using block instead of
 *  the delegate and the dataSource.
 */
@interface UITableView (GCDelegateAndDataSourceBlock)

- (void)usingBlocks;

#pragma mark - datasource property
/**
 *  equal to -> |tableView:cellForRowAtIndexPath:|
 */
@property (nonatomic, copy) UITableViewCell* (^blockForRowCell)(UITableView* tableView, NSIndexPath* indexPath);

/**
 *  equal to -> |numberOfSectionsInTableView:|
 */
@property (nonatomic, copy) int (^blockForSectionNumber)(UITableView* tableView);

/**
 *  equal to -> |tableView:numberOfRowsInSection:|
 */
@property (nonatomic, copy) int (^blockForRowNumber)(UITableView* tableView, int section);

/**
 *  equal to -> |sectionIndexTitlesForTableView:|
 */
@property (nonatomic, copy) NSArray* (^blockForSectionIndexTitles)(UITableView* tableView);

/**
 *  equal to -> |tableView:sectionForSectionIndexTitle:atIndex:|
 */
@property (nonatomic, copy) int (^blockForSectionIndex)(UITableView* tableView, NSString* title, int index);

/**
 *  equal to -> |tableView:titleForFooterInSection:|
 */
@property (nonatomic, copy) NSString* (^blockForFooterTitle)(UITableView* tableView, int section);

/**
 *  equal to -> |tableView:titleForHeaderInSection:|
 */
@property (nonatomic, copy) NSString* (^blockForHeaderTitle)(UITableView* tableView, int seciton);

/**
 *  equal to -> |tableView:commitEditingStyle:forRowAtIndexPath:|
 */
@property (nonatomic, copy) void (^blockForRowCommitEditStyleForRow)(UITableView* tableView, UITableViewCellEditingStyle style, NSIndexPath* indexPath);

/**
 *  equal to -> |tableView:canEditRowAtIndexPath:|
 */
@property (nonatomic, copy) BOOL (^blockForRowCanEditRow)(UITableView* tableView, NSIndexPath* indexPath);

/**
 *  equal to -> |tableView:canMoveRowAtIndexPath:|
 */
@property (nonatomic, copy) BOOL (^blockForRowCanMoveRow)(UITableView* tableView, NSIndexPath* indexPath);

/**
 *  equal to -> |tableView:moveRowAtIndexPath:toIndexPath:|
 */
@property (nonatomic, copy) void (^blockForRowMove)(UITableView* tableView, NSIndexPath* fromIndexPath, NSIndexPath* toIndexPath);







#pragma mark - delegate property

/**
 *  equal to -> |tableView:heightForRowAtIndexPath:|
 */
@property (nonatomic, copy) float (^blockForRowHeight)(UITableView* tableView, NSIndexPath* indexPath);

/**
 *  equal to -> |tableView:estimatedHeightForRowAtIndexPath:|
 */
@property (nonatomic, copy) float (^blockForRowEstimatedHeight)(UITableView* tableView, NSIndexPath* indexPath);

/**
 *  equal to -> |tableView:indentationLevelForRowAtIndexPath:|
 */
@property (nonatomic, copy) int (^blockForRowIndentationLevel)(UITableView* tableView, NSIndexPath* indexPath) NS_AVAILABLE_IOS(8_0);

/**
 *  equal to -> |tableView:willDisplayCell:forRowAtIndexPath:|
 */
@property (nonatomic, copy) void (^blockForRowCellWillDisplay)(UITableView* tableView, UITableViewCell* cell, NSIndexPath* indexPath);

/**
 *  equal to -> |tableView:editActionsForRowAtIndexPath:|
 */
@property (nonatomic, copy) NSArray* (^blockForRowEditActions)(UITableView* tableView, NSIndexPath* indexPath);

/**
 *  euqal to -> |tableView:accessoryButtonTappedForRowWithIndexPath:|
 */
@property (nonatomic, copy) void (^blockForRowAccessoryButtonTapped)(UITableView* tableView, NSIndexPath* indexPath);

/**
 *  equal to -> |tableView:willSelectRowAtIndexPath:|
 */
@property (nonatomic, copy) NSIndexPath* (^blockForRowWillSelect)(UITableView* tableView, NSIndexPath* indexPath);

/**
 *  equal to -> |tableView:didSelectRowAtIndexPath:|
 */
@property (nonatomic, copy) void (^blockForRowDidSelect)(UITableView* tableView, NSIndexPath* indexPath);

/**
 *  equal to -> |tableView:willDeselectRowAtIndexPath:|
 */
@property (nonatomic, copy) NSIndexPath* (^blockForRowWillDeselect)(UITableView* tableView, NSIndexPath* indexPath);

/**
 *  equal to -> |tableView:didDeselectRowAtIndexPath:|
 */
@property (nonatomic, copy) void (^blockForRowDidDeselecte)(UITableView* tableView, NSIndexPath* indexPath);

/**
 *  equal to -> |tableView:viewForHeaderInSection:|
 */
@property (nonatomic, copy) UIView* (^blockForHeaderView)(UITableView* tableView, int section);

/**
 *  equal to -> |tableView:viewForFooterInSection:|
 */
@property (nonatomic, copy) UIView* (^blockForFooterView)(UITableView* tableView, int section);

/**
 *  equal to -> |tableView:heightForHeaderInSection:|
 */
@property (nonatomic, copy) float (^blockForHeaderHeight)(UITableView* tableView, int section);

/**
 *  equal to -> |tableView:estimatedHeightForHeaderInSection:|
 */
@property (nonatomic, copy) float (^blockForHeaderEstimatedHeight)(UITableView* tableView, int section);

/**
 *  equal to -> |tableView:heightForFooterInSection:|
 */
@property (nonatomic, copy) float (^blockForFooterHeight)(UITableView* tableView, int section);

/**
 *  equal to -> |tableView:estimatedHeightForFooterInSection:|
 */
@property (nonatomic, copy) float (^blockForFooterEstimatedHeight)(UITableView* tableView, int section);

/**
 *  equal to -> |tableView:willDisplayHeaderView:forSection:|
 */
@property (nonatomic, copy) void (^blockForHeaderViewWillDisplay)(UITableView* tableView, UIView* headerView, int section);

/**
 *  equal to -> |tableView:willDisplayFooterView:forSection:|
 */
@property (nonatomic, copy) void (^blockForFooterViewWillDisplay)(UITableView* tableView, UIView* footerView, int section);

/**
 *  equal to -> |tableView:willBeginEditingRowAtIndexPath:|
 */
@property (nonatomic, copy) void (^blockForRowWillBeginEditing)(UITableView* tableView, NSIndexPath* indexPath);

/**
 *  equal to -> |tableView:didEndEditingRowAtIndexPath:|
 */
@property (nonatomic, copy) void (^blockForRowDidEndEditing)(UITableView* tableView, NSIndexPath* indexPath);

/**
 *  equal to -> |tableView:editingStyleForRowAtIndexPath:|
 */
@property (nonatomic, copy) UITableViewCellEditingStyle (^blockForRowEditingStyle)(UITableView* tableView, NSIndexPath* indexPaht);

/**
 *  equal to -> |tableView:titleForDeleteConfirmationButtonForRowAtIndexPath:|
 */
@property (nonatomic, copy) NSString* (^blockForRowDeleteConfirmationButtonTitle)(UITableView* tableView, NSIndexPath* indexPath);

/**
 *  equal to -> |tableView:shouldIndentWhileEditingRowAtIndexPath:|
 */
@property (nonatomic, copy) BOOL (^blockForRowShouldIndentWhileEditing)(UITableView* tableView, NSIndexPath* indexPath);

/**
 *  equal to -> |tableView:targetIndexPathForMoveFromRowAtIndexPath:toProposedIndexPath:|
 */
@property (nonatomic, copy) NSIndexPath* (^blockForRowMoveTargetIndexPath)(UITableView* tableView, NSIndexPath* fromIndexPath, NSIndexPath* proposedIndexPath);

/**
 *  equal to -> |tableView:didEndDisplayingCell:forRowAtIndexPath:|
 */
@property (nonatomic, copy) void (^blockForRowDidEndDisplayingCell)(UITableView* tableView, UITableViewCell* cell, NSIndexPath* indexPath);

/**
 *  equal to -> |tableView:didEndDisplayingHeaderView:forSection:|
 */
@property (nonatomic, copy) void (^blockForHeaderViewDidEndDisplaying)(UITableView* tableView, UIView* headerView, int section);

/**
 *  equal to -> |tableView:didEndDisplayingFooterView:forSection:|
 */
@property (nonatomic, copy) void (^blockForFooterViewDidEndDisplaying)(UITableView* tableView, UIView* footerView, int section);

/**
 *  equal to -> |tableView:shouldShowMenuForRowAtIndexPath:|
 */
@property (nonatomic, copy) BOOL (^blockForRowShouldShowMenu)(UITableView* tableView, NSIndexPath* indexPath);

/**
 *  equal to -> |tableView:canPerformAction:forRowAtIndexPath:withSender:|
 */
@property (nonatomic, copy) BOOL (^blockForRowCanPerformAction)(UITableView* tableView, SEL action, NSIndexPath* indexPath, id sender);

/**
 *  equal to -> |tableView:performAction:forRowAtIndexPath:withSender:|
 */
@property (nonatomic, copy) void (^blockForRowPerformAction)(UITableView* tableView, SEL action, NSIndexPath* indexPath, id sender);

/**
 *  equal to -> |tableView:shouldHighlightRowAtIndexPath:|
 */
@property (nonatomic, copy) BOOL (^blockForRowShouldHighlight)(UITableView* tableView, NSIndexPath* indexPath);

/**
 *  equal to -> |tableView:didHighlightRowAtIndexPath:|
 */
@property (nonatomic, copy) void (^blockForRowDidHighlight)(UITableView* tableView, NSIndexPath* indexPath);

/**
 *  equal to -> |tableView:didUnhighlightRowAtIndexPath:|
 */
@property (nonatomic, copy) void (^blockForRowDidUnhighlight)(UITableView* tableView, NSIndexPath* indexPath);


@end
