//
//  UITableView+GCBlock.m
//  IPSShelf
//
//  Created by zhoujinqiang on 14-8-6.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "UITableView+GCDelegateAndDataSourceBlock.h"

#import <objc/runtime.h>
#import "NSObject+GCAccessor.h"
#import "UITableViewDelegateAndDataSourceImplementationProxy.h"


#pragma mark - UITableView+GCBlock

@implementation UITableView (GCDelegateAndDataSourceBlock)

- (void)usingBlocks {
    static char const UITableViewDelegateAndDataSourceImplementationProxyKey;
    UITableViewDelegateAndDataSourceImplementationProxy* implement = nil;
    implement = objc_getAssociatedObject(self, &UITableViewDelegateAndDataSourceImplementationProxyKey);
    if (!implement) {
        implement = [[UITableViewDelegateAndDataSourceImplementationProxy alloc] init];
        implement.owner = self;
        objc_setAssociatedObject(self, &UITableViewDelegateAndDataSourceImplementationProxyKey, implement, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    self.delegate = (id)implement;
    self.dataSource = (id)implement;
}

@dynamic blockForRowCell;
@dynamic blockForSectionNumber;
@dynamic blockForRowNumber;
@dynamic blockForSectionIndexTitles;
@dynamic blockForSectionIndex;
@dynamic blockForFooterTitle;
@dynamic blockForHeaderTitle;
@dynamic blockForRowCommitEditStyleForRow;
@dynamic blockForRowCanEditRow;
@dynamic blockForRowCanMoveRow;
@dynamic blockForRowMove;

@dynamic blockForRowHeight;
@dynamic blockForRowEstimatedHeight;
@dynamic blockForRowIndentationLevel;
@dynamic blockForRowCellWillDisplay;
@dynamic blockForRowEditActions;
@dynamic blockForRowAccessoryButtonTapped;
@dynamic blockForRowWillSelect;
@dynamic blockForRowDidSelect;
@dynamic blockForRowWillDeselect;
@dynamic blockForRowDidDeselecte;
@dynamic blockForHeaderView;
@dynamic blockForFooterView;
@dynamic blockForHeaderHeight;
@dynamic blockForHeaderEstimatedHeight;
@dynamic blockForFooterHeight;
@dynamic blockForFooterEstimatedHeight;
@dynamic blockForHeaderViewWillDisplay;
@dynamic blockForFooterViewWillDisplay;
@dynamic blockForRowWillBeginEditing;
@dynamic blockForRowDidEndEditing;
@dynamic blockForRowEditingStyle;
@dynamic blockForRowDeleteConfirmationButtonTitle;
@dynamic blockForRowShouldIndentWhileEditing;
@dynamic blockForRowMoveTargetIndexPath;
@dynamic blockForRowDidEndDisplayingCell;
@dynamic blockForHeaderViewDidEndDisplaying;
@dynamic blockForFooterViewDidEndDisplaying;
@dynamic blockForRowShouldShowMenu;
@dynamic blockForRowCanPerformAction;
@dynamic blockForRowPerformAction;
@dynamic blockForRowShouldHighlight;
@dynamic blockForRowDidHighlight;
@dynamic blockForRowDidUnhighlight;

+ (void)load {
    [self extensionAccessorGenerator];
}

+ (NSArray *)extensionAccessorNonatomicCopyPropertyNames {
    return @[@"blockForRowCell",
             @"blockForSectionNumber",
             @"blockForRowNumber",
             @"blockForSectionIndexTitles",
             @"blockForSectionIndex",
             @"blockForFooterTitle",
             @"blockForHeaderTitle",
             @"blockForRowCommitEditStyleForRow",
             @"blockForRowCanEditRow",
             @"blockForRowCanMoveRow",
             @"blockForRowMove",
             @"blockForRowHeight",
             @"blockForRowEstimatedHeight",
             @"blockForRowIndentationLevel",
             @"blockForRowCellWillDisplay",
             @"blockForRowEditActions",
             @"blockForRowAccessoryButtonTapped",
             @"blockForRowWillSelect",
             @"blockForRowDidSelect",
             @"blockForRowWillDeselect",
             @"blockForRowDidDeselecte",
             @"blockForHeaderView",
             @"blockForFooterView",
             @"blockForHeaderHeight",
             @"blockForHeaderEstimatedHeight",
             @"blockForFooterHeight",
             @"blockForFooterEstimatedHeight",
             @"blockForHeaderViewWillDisplay",
             @"blockForFooterViewWillDisplay",
             @"blockForRowWillBeginEditing",
             @"blockForRowDidEndEditing",
             @"blockForRowEditingStyle",
             @"blockForRowDeleteConfirmationButtonTitle",
             @"blockForRowShouldIndentWhileEditing",
             @"blockForRowMoveTargetIndexPath",
             @"blockForRowDidEndDisplayingCell",
             @"blockForHeaderViewDidEndDisplaying",
             @"blockForFooterViewDidEndDisplaying",
             @"blockForRowShouldShowMenu",
             @"blockForRowCanPerformAction",
             @"blockForRowPerformAction",
             @"blockForRowShouldHighlight",
             @"blockForRowDidHighlight",
             @"blockForRowDidUnhighlight"];
}

@end

