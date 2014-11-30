//
//  UICollectionView+GCDelegateAndDataSourceBlock.m
//  GCExtension
//
//  Created by njgarychow on 11/3/14.
//  Copyright (c) 2014 zhoujinqiang. All rights reserved.
//

#import "UICollectionView+GCDelegateAndDataSourceBlock.h"
#import "NSObject+GCAccessor.h"
#import "UICollectionViewDelegateAndDataSourceImplementationProxy.h"
#import <objc/runtime.h>

@implementation UICollectionView (GCDelegateAndDataSourceBlock)

- (void)usingBlocks {
    static char const UICollectionViewDelegateAndDataSourceImplementationProxyKey;
    UICollectionViewDelegateAndDataSourceImplementationProxy* implement = nil;
    implement = objc_getAssociatedObject(self, &UICollectionViewDelegateAndDataSourceImplementationProxyKey);
    if (!implement) {
        implement = [[UICollectionViewDelegateAndDataSourceImplementationProxy alloc] init];
        implement.owner = self;
        objc_setAssociatedObject(self, &UICollectionViewDelegateAndDataSourceImplementationProxyKey, implement, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    self.delegate = (id)implement;
    self.dataSource = (id)implement;
}


@dynamic blockForItemNumber;
@dynamic blockForSectionNumber;
@dynamic blockForItemCell;
@dynamic blockForSupplementaryElement;

@dynamic blockForItemShouldSelect;
@dynamic blockForItemDidSelect;
@dynamic blockForItemShouldDeselect;
@dynamic blockForItemDidDeselect;
@dynamic blockForItemShouldHighlight;
@dynamic blockForItemDidHighlight;
@dynamic blockForItemDidUnhighlight;
@dynamic blockForItemWillDisplay;
@dynamic blockForSupplementaryWillDisplay;
@dynamic blockForItemCellDidEndDisplay;
@dynamic blockForSupplementaryDidEndDisplay;
@dynamic blockForLayoutTransition;
@dynamic blockForItemMenuShouldShow;
@dynamic blockForItemCanPerformAction;
@dynamic blockForItemPerformAction;

@dynamic blockForFlowLayoutSize;
@dynamic blockForFlowLayoutSectionInset;
@dynamic blockForFlowLayoutSectionMinimumSpacing;
@dynamic blockForFlowLayoutSectionMinimumInteritemSpacing;
@dynamic blockForFlowLayoutHeaderReferenceSize;
@dynamic blockForFlowLayoutFooterReferenceSize;

+ (void)load {
    [self extensionAccessorGenerator];
}

+ (NSArray *)extensionAccessorNonatomicCopyPropertyNames {
    return @[@"blockForItemNumber",
             @"blockForSectionNumber",
             @"blockForItemCell",
             @"blockForSupplementaryElement",
             @"blockForItemShouldSelect",
             @"blockForItemDidSelect",
             @"blockForItemShouldDeselect",
             @"blockForItemDidDeselect",
             @"blockForItemShouldHighlight",
             @"blockForItemDidHighlight",
             @"blockForItemDidUnhighlight",
             @"blockForItemWillDisplay",
             @"blockForSupplementaryWillDisplay",
             @"blockForItemCellDidEndDisplay",
             @"blockForSupplementaryDidEndDisplay",
             @"blockForLayoutTransition",
             @"blockForItemMenuShouldShow",
             @"blockForItemCanPerformAction",
             @"blockForItemPerformAction",
             @"blockForFlowLayoutSize",
             @"blockForFlowLayoutSectionInset",
             @"blockForFlowLayoutSectionMinimumSpacing",
             @"blockForFlowLayoutSectionMinimumInteritemSpacing",
             @"blockForFlowLayoutHeaderReferenceSize",
             @"blockForFlowLayoutFooterReferenceSize"];
}

@end
