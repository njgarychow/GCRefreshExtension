//
//  UIScrollViewDelegateImplementationProxy.m
//  GCExtension
//
//  Created by zhoujinqiang on 14-10-14.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "UIScrollViewDelegateImplementationProxy.h"
#import "UIScrollView+GCDelegateBlock.h"

@implementation UIScrollViewDelegateImplementation

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    scrollView.blockForDidScroll(scrollView);
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    scrollView.blockForWillBeginDragging(scrollView);
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    scrollView.blockForWillEndDragging(scrollView, velocity, targetContentOffset);
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    scrollView.blockForDidEndDragging(scrollView, decelerate);
}
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    return scrollView.blockForShouldScrollToTop(scrollView);
}
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    scrollView.blockForDidScrollToTop(scrollView);
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    scrollView.blockForWillBeginDecelerating(scrollView);
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    scrollView.blockForDidEndDecelerating(scrollView);
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return scrollView.blockForViewForZooming(scrollView);
}
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    scrollView.blockForWillBeginZooming(scrollView, view);
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    scrollView.blockForDidEndZooming(scrollView, view, scale);
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    scrollView.blockForDidZoom(scrollView);
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    scrollView.blockForDidEndScrollingAnimation(scrollView);
}

@end






@interface UIScrollViewDelegateImplementationProxy ()

@property (nonatomic, strong) UIScrollViewDelegateImplementation* realObject;

@end


@implementation UIScrollViewDelegateImplementationProxy

- (id)init {
    self.realObject = [[UIScrollViewDelegateImplementation alloc] init];
    return self;
}

#define BlockStatementTest(statement) do { if (statement) { return YES; } } while (0)
#define Statement(block, selectorString) (block && [selectorString isEqualToString:targetSelectorString])
#define BlockStatement(block, selectorString) BlockStatementTest(Statement(block, selectorString))
- (BOOL)respondsToSelector:(SEL)aSelector {
    NSString* targetSelectorString = NSStringFromSelector(aSelector);
    
    BlockStatement(self.owner.blockForDidScroll, @"scrollViewDidScroll:");
    BlockStatement(self.owner.blockForWillBeginDragging, @"scrollViewWillBeginDragging:");
    BlockStatement(self.owner.blockForWillEndDragging, @"scrollViewWillEndDragging:withVelocity:targetContentOffset:");
    BlockStatement(self.owner.blockForDidEndDragging, @"scrollViewDidEndDragging:willDecelerate:");
    BlockStatement(self.owner.blockForShouldScrollToTop, @"scrollViewShouldScrollToTop:");
    BlockStatement(self.owner.blockForDidScrollToTop, @"scrollViewDidScrollToTop:");
    BlockStatement(self.owner.blockForWillBeginDecelerating, @"scrollViewWillBeginDecelerating:");
    BlockStatement(self.owner.blockForDidEndDecelerating, @"scrollViewDidEndDecelerating:");
    BlockStatement(self.owner.blockForViewForZooming, @"viewForZoomingInScrollView:");
    BlockStatement(self.owner.blockForWillBeginZooming, @"scrollViewWillBeginZooming:withView:");
    BlockStatement(self.owner.blockForDidEndZooming, @"scrollViewDidEndZooming:withView:atScale:");
    BlockStatement(self.owner.blockForDidZoom, @"scrollViewDidZoom:");
    BlockStatement(self.owner.blockForDidEndScrollingAnimation, @"scrollViewDidEndScrollingAnimation:");
    
    return NO;
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.realObject methodSignatureForSelector:sel];
}
- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.realObject];
}

@end
