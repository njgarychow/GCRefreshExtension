//
//  UICollectionViewDelegateAndDataSourceImplementProxy.m
//  GCExtension
//
//  Created by njgarychow on 11/3/14.
//  Copyright (c) 2014 zhoujinqiang. All rights reserved.
//

#import "UICollectionViewDelegateAndDataSourceImplementationProxy.h"

#import "UICollectionView+GCDelegateAndDataSourceBlock.h"


@interface UICollectionViewDelegateAndDataSourceImplementation : UIScrollViewDelegateImplementation <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@end

@implementation UICollectionViewDelegateAndDataSourceImplementation

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return collectionView.blockForItemNumber(collectionView, (int)section);
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return collectionView.blockForSectionNumber(collectionView);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.blockForItemCell(collectionView, indexPath);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    return collectionView.blockForSupplementaryElement(collectionView, kind, indexPath);
}


#pragma mark - UICollectionViewDelegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.blockForItemShouldSelect(collectionView, indexPath);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    collectionView.blockForItemDidSelect(collectionView, indexPath);
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.blockForItemShouldDeselect(collectionView, indexPath);
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    collectionView.blockForItemDidDeselect(collectionView, indexPath);
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.blockForItemShouldHighlight(collectionView, indexPath);
}
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    collectionView.blockForItemDidHighlight(collectionView, indexPath);
}
- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    collectionView.blockForItemDidUnhighlight(collectionView, indexPath);
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    collectionView.blockForItemWillDisplay(collectionView, cell, indexPath);
}
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    collectionView.blockForSupplementaryWillDisplay(collectionView, view, elementKind, indexPath);
}
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    collectionView.blockForItemCellDidEndDisplay(collectionView, cell, indexPath);
}
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    collectionView.blockForSupplementaryDidEndDisplay(collectionView, view, elementKind, indexPath);
}
- (UICollectionViewTransitionLayout *)collectionView:(UICollectionView *)collectionView transitionLayoutForOldLayout:(UICollectionViewLayout *)fromLayout newLayout:(UICollectionViewLayout *)toLayout {
    return collectionView.blockForLayoutTransition(collectionView, fromLayout, toLayout);
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.blockForItemMenuShouldShow(collectionView, indexPath);
}
- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    return collectionView.blockForItemCanPerformAction(collectionView, action, indexPath, sender);
}
- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    collectionView.blockForItemPerformAction(collectionView, action, indexPath, sender);
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.blockForFlowLayoutSize(collectionView, collectionViewLayout, indexPath);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return collectionView.blockForFlowLayoutSectionInset(collectionView, collectionViewLayout, (int)section);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return collectionView.blockForFlowLayoutSectionMinimumSpacing(collectionView, collectionViewLayout, (int)section);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return collectionView.blockForFlowLayoutSectionMinimumInteritemSpacing(collectionView, collectionViewLayout, (int)section);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return collectionView.blockForFlowLayoutHeaderReferenceSize(collectionView, collectionViewLayout, (int)section);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return collectionView.blockForFlowLayoutFooterReferenceSize(collectionView, collectionViewLayout, (int)section);
}

@end







@interface UICollectionViewDelegateAndDataSourceImplementationProxy ()

@property (nonatomic, strong) UICollectionViewDelegateAndDataSourceImplementation* realObject;

@end

@implementation UICollectionViewDelegateAndDataSourceImplementationProxy

- (instancetype)init {
    _realObject = [[UICollectionViewDelegateAndDataSourceImplementation alloc] init];
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
    BlockStatement(self.owner.blockForItemNumber, @"collectionView:numberOfItemsInSection:");
    BlockStatement(self.owner.blockForSectionNumber, @"numberOfSectionsInCollectionView:");
    BlockStatement(self.owner.blockForItemCell, @"collectionView:cellForItemAtIndexPath:");
    BlockStatement(self.owner.blockForSupplementaryElement, @"collectionView:viewForSupplementaryElementOfKind:atIndexPath:");
    
    BlockStatement(self.owner.blockForItemShouldSelect, @"collectionView:shouldSelectItemAtIndexPath:");
    BlockStatement(self.owner.blockForItemDidSelect, @"collectionView:didSelectItemAtIndexPath:");
    BlockStatement(self.owner.blockForItemShouldDeselect, @"collectionView:shouldDeselectItemAtIndexPath:");
    BlockStatement(self.owner.blockForItemDidDeselect, @"collectionView:didDeselectItemAtIndexPath:");
    BlockStatement(self.owner.blockForItemShouldHighlight, @"collectionView:shouldHighlightItemAtIndexPath:");
    BlockStatement(self.owner.blockForItemDidHighlight, @"collectionView:didHighlightItemAtIndexPath:");
    BlockStatement(self.owner.blockForItemDidUnhighlight, @"collectionView:didUnhighlightItemAtIndexPath:");
    BlockStatement(self.owner.blockForItemWillDisplay, @"collectionView:willDisplayCell:forItemAtIndexPath:");
    BlockStatement(self.owner.blockForSupplementaryWillDisplay, @"collectionView:willDisplaySupplementaryView:forElementKind:atIndexPath:");
    BlockStatement(self.owner.blockForItemCellDidEndDisplay, @"collectionView:didEndDisplayingCell:forItemAtIndexPath:");
    BlockStatement(self.owner.blockForSupplementaryDidEndDisplay, @"collectionView:didEndDisplayingSupplementaryView:forElementOfKind:atIndexPath:");
    BlockStatement(self.owner.blockForLayoutTransition, @"collectionView:transitionLayoutForOldLayout:newLayout:");
    BlockStatement(self.owner.blockForItemMenuShouldShow, @"collectionView:shouldShowMenuForItemAtIndexPath");
    BlockStatement(self.owner.blockForItemCanPerformAction, @"collectionView:canPerformAction:forItemAtIndexPath:withSender:");
    BlockStatement(self.owner.blockForItemPerformAction, @"collectionView:performAction:forItemAtIndexPath:withSender:");
    
    BlockStatement(self.owner.blockForFlowLayoutSize, @"collectionView:layout:sizeForItemAtIndexPath:");
    BlockStatement(self.owner.blockForFlowLayoutSectionInset, @"collectionView:layout:insetForSectionAtIndex:");
    BlockStatement(self.owner.blockForFlowLayoutSectionMinimumSpacing, @"collectionView:layout:minimumLineSpacingForSectionAtIndex:");
    BlockStatement(self.owner.blockForFlowLayoutSectionMinimumInteritemSpacing, @"collectionView:layout:minimumInteritemSpacingForSectionAtIndex:");
    BlockStatement(self.owner.blockForFlowLayoutHeaderReferenceSize, @"collectionView:layout:referenceSizeForHeaderInSection:");
    BlockStatement(self.owner.blockForFlowLayoutFooterReferenceSize, @"collectionView:layout:referenceSizeForFooterInSection:");
    
    
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
