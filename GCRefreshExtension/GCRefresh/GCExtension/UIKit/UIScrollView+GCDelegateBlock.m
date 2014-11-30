//
//  UIScrollView+GCDelegateBlock.m
//  GCExtension
//
//  Created by zhoujinqiang on 14-10-14.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "UIScrollView+GCDelegateBlock.h"
#import "UIScrollViewDelegateImplementationProxy.h"
#import "NSObject+GCAccessor.h"

@interface UIScrollView (GCDelegateBlockProperty)

@property (nonatomic, strong) UIScrollViewDelegateImplementationProxy* implementation;

@end

@implementation UIScrollView (GCDelegateBlock)

- (void)usingBlocks {
    if (!self.implementation) {
        self.implementation = [[UIScrollViewDelegateImplementationProxy alloc] init];
        self.implementation.owner = self;
    }
    self.delegate = (id)self.implementation;
}

@dynamic blockForDidScroll;
@dynamic blockForWillBeginDragging;
@dynamic blockForWillEndDragging;
@dynamic blockForDidEndDragging;
@dynamic blockForShouldScrollToTop;
@dynamic blockForDidScrollToTop;
@dynamic blockForWillBeginDecelerating;
@dynamic blockForDidEndDecelerating;
@dynamic blockForViewForZooming;
@dynamic blockForWillBeginZooming;
@dynamic blockForDidEndZooming;
@dynamic blockForDidZoom;
@dynamic blockForDidEndScrollingAnimation;

+ (void)load {
    [self extensionAccessorGenerator];
}

+ (NSArray *)extensionAccessorNonatomicStrongPropertyNames {
    return @[@"implementation"];
}
+ (NSArray *)extensionAccessorNonatomicCopyPropertyNames {
    return @[@"blockForDidScroll",
             @"blockForWillBeginDragging",
             @"blockForWillEndDragging",
             @"blockForDidEndDragging",
             @"blockForShouldScrollToTop",
             @"blockForDidScrollToTop",
             @"blockForWillBeginDecelerating",
             @"blockForDidEndDecelerating",
             @"blockForViewForZooming",
             @"blockForWillBeginZooming",
             @"blockForDidEndZooming",
             @"blockForDidZoom",
             @"blockForDidEndScrollingAnimation"];
}

@end
