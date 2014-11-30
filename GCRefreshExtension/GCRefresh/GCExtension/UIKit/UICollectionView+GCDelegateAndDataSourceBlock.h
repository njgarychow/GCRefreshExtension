//
//  UICollectionView+GCDelegateAndDataSourceBlock.h
//  GCExtension
//
//  Created by njgarychow on 11/3/14.
//  Copyright (c) 2014 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (GCDelegateAndDataSourceBlock)

- (void)usingBlocks;

/**
 *  equal to -> |collectionView:numberOfItemsInSection:|
 */
@property (nonatomic, copy) int (^blockForItemNumber)(UICollectionView* collectionView, int section);

/**
 *  equal to -> |numberOfSectionsInCollectionView:|
 */
@property (nonatomic, copy) int (^blockForSectionNumber)(UICollectionView* collectionView);

/**
 *  equal to -> |collectionView:cellForItemAtIndexPath:|
 */
@property (nonatomic, copy) UICollectionViewCell* (^blockForItemCell)(UICollectionView* collectionView, NSIndexPath* indexPath);

/**
 *  equal to -> |collectionView:viewForSupplementaryElementOfKind:atIndexPath:|
 */
@property (nonatomic, copy) UICollectionReusableView* (^blockForSupplementaryElement)(UICollectionView* collectionView, NSString* kind, NSIndexPath* indexPath);




/**
 *  equal to -> |collectionView:shouldSelectItemAtIndexPath:|
 */
@property (nonatomic, copy) BOOL (^blockForItemShouldSelect)(UICollectionView* collectionView, NSIndexPath* indexPath);

/**
 *  equal to -> |collectionView:didSelectItemAtIndexPath:|
 */
@property (nonatomic, copy) void (^blockForItemDidSelect)(UICollectionView* collectionView, NSIndexPath* indexPath);

/**
 *  equal to -> |collectionView:shouldDeselectItemAtIndexPath:|
 */
@property (nonatomic, copy) BOOL (^blockForItemShouldDeselect)(UICollectionView* collectionView, NSIndexPath* indexPath);

/**
 *  equal to -> |collectionView:didDeselectItemAtIndexPath:|
 */
@property (nonatomic, copy) void (^blockForItemDidDeselect)(UICollectionView* collectionView, NSIndexPath* indexPath);

/**
 *  equal to -> |collectionView:shouldHighlightItemAtIndexPath:|
 */
@property (nonatomic, copy) BOOL (^blockForItemShouldHighlight)(UICollectionView* collectionView, NSIndexPath* indexPath);

/**
 *  equal to -> |collectionView:didHighlightItemAtIndexPath:|
 */
@property (nonatomic, copy) void (^blockForItemDidHighlight)(UICollectionView* collectionView, NSIndexPath* indexPath);

/**
 *  equal to -> |collectionView:didUnhighlightItemAtIndexPath:|
 */
@property (nonatomic, copy) void (^blockForItemDidUnhighlight)(UICollectionView* collectionView, NSIndexPath* indexPath);

/**
 *  equal to -> |collectionView:willDisplayCell:forItemAtIndexPath:|
 */
@property (nonatomic, copy) void (^blockForItemWillDisplay)(UICollectionView* collectionView, UICollectionViewCell* cell, NSIndexPath* indexPath);

/**
 *  equal to -> |collectionView:willDisplaySupplementaryView:forElementKind:atIndexPath:|
 */
@property (nonatomic, copy) void (^blockForSupplementaryWillDisplay)(UICollectionView* collectionView, UICollectionReusableView* view, NSString* elementKind, NSIndexPath* indexPath);

/**
 *  equal to -> |collectionView:didEndDisplayingCell:forItemAtIndexPath:|
 */
@property (nonatomic, copy) void (^blockForItemCellDidEndDisplay)(UICollectionView* collectionView, UICollectionViewCell* cell, NSIndexPath* indexPath);

/**
 *  equal to -> |collectionView:didEndDisplayingSupplementaryView:forElementOfKind:atIndexPath:|
 */
@property (nonatomic, copy) void (^blockForSupplementaryDidEndDisplay)(UICollectionView* collectionView, UICollectionReusableView* view, NSString* elementKind, NSIndexPath* indexPath);

/**
 *  equal to -> |collectionView:transitionLayoutForOldLayout:newLayout:|
 */
@property (nonatomic, copy) UICollectionViewTransitionLayout* (^blockForLayoutTransition)(UICollectionView* collectionView, UICollectionViewLayout* fromLayout, UICollectionViewLayout* toLayout);

/**
 *  equal to -> |collectionView:shouldShowMenuForItemAtIndexPath:|
 */
@property (nonatomic, copy) BOOL (^blockForItemMenuShouldShow)(UICollectionView* collectionView, NSIndexPath* indexPath);

/**
 *  equal to -> |collectionView:canPerformAction:forItemAtIndexPath:withSender:|
 */
@property (nonatomic, copy) BOOL (^blockForItemCanPerformAction)(UICollectionView* collectionView, SEL action, NSIndexPath* indexPath, id sender);

/**
 *  equal to -> |collectionView:performAction:forItemAtIndexPath:withSender:|
 */
@property (nonatomic, copy) void (^blockForItemPerformAction)(UICollectionView* collectionView, SEL action, NSIndexPath* indexPath, id sender);





/**
 *  equal to -> |collectionView:layout:sizeForItemAtIndexPath:|
 */
@property (nonatomic, copy) CGSize (^blockForFlowLayoutSize)(UICollectionView* collectionView, UICollectionViewLayout* layout, NSIndexPath* indexPath);

/**
 *  equal to -> |collectionView:layout:insetForSectionAtIndex:|
 */
@property (nonatomic, copy) UIEdgeInsets (^blockForFlowLayoutSectionInset)(UICollectionView* collectionView, UICollectionViewLayout* layout, int section);

/**
 *  equal to -> |collectionView:layout:minimumLineSpacingForSectionAtIndex:|
 */
@property (nonatomic, copy) CGFloat (^blockForFlowLayoutSectionMinimumSpacing)(UICollectionView* collectionView, UICollectionViewLayout* layout, int section);

/**
 *  equal to -> |collectionView:layout:minimumInteritemSpacingForSectionAtIndex:|
 */
@property (nonatomic, copy) CGFloat (^blockForFlowLayoutSectionMinimumInteritemSpacing)(UICollectionView* collectionView, UICollectionViewLayout* layout, int section);

/**
 *  equal to -> |collectionView:layout:referenceSizeForHeaderInSection:|
 */
@property (nonatomic, copy) CGSize (^blockForFlowLayoutHeaderReferenceSize)(UICollectionView* collectionView, UICollectionViewLayout* layout, int section);

/**
 *  equal to -> |collectionView:layout:referenceSizeForFooterInSection:|
 */
@property (nonatomic, copy) CGSize (^blockForFlowLayoutFooterReferenceSize)(UICollectionView* collectionView, UICollectionViewLayout* layout, int section);

@end
