//
//  UIScrollView+GCDelegateBlock.h
//  GCExtension
//
//  Created by zhoujinqiang on 14-10-14.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (GCDelegateBlock)

- (void)usingBlocks;

/**
 *  equal to -> |scrollViewDidScroll:|
 */
@property (nonatomic, copy) void (^blockForDidScroll)(UIScrollView* scrollView);

/**
 *  equal to -> |scrollViewWillBeginDragging:|
 */
@property (nonatomic, copy) void (^blockForWillBeginDragging)(UIScrollView* scrollView);

/**
 *  equal to -> |scrollViewWillEndDragging:withVelocity:targetContentOffset:|
 */
@property (nonatomic, copy) void (^blockForWillEndDragging)(UIScrollView* scrollView, CGPoint velocity, CGPoint* targetContentOffset);

/**
 *  equal to -> |scrollViewDidEndDragging:willDecelerate:|
 */
@property (nonatomic, copy) void (^blockForDidEndDragging)(UIScrollView* scrollView, BOOL decelerate);

/**
 *  equal to -> |scrollViewShouldScrollToTop:|
 */
@property (nonatomic, copy) BOOL (^blockForShouldScrollToTop)(UIScrollView* scrollView);

/**
 *  equal to -> |scrollViewDidScrollToTop:|
 */
@property (nonatomic, copy) void (^blockForDidScrollToTop)(UIScrollView* scrollView);

/**
 *  equal to -> |scrollViewWillBeginDecelerating:|
 */
@property (nonatomic, copy) void (^blockForWillBeginDecelerating)(UIScrollView* scrollView);

/**
 *  equal to -> |scrollViewDidEndDecelerating:|
 */
@property (nonatomic, copy) void (^blockForDidEndDecelerating)(UIScrollView* scrollView);

/**
 *  equal to -> |viewForZoomingInScrollView:|
 */
@property (nonatomic, copy) UIView* (^blockForViewForZooming)(UIScrollView* scrollView);

/**
 *  equal to -> |scrollViewWillBeginZooming:withView:|
 */
@property (nonatomic, copy) void (^blockForWillBeginZooming)(UIScrollView* scrollView, UIView* zoomingView);

/**
 *  equal to -> |scrollViewDidEndZooming:withView:atScale:|
 */
@property (nonatomic, copy) void (^blockForDidEndZooming)(UIScrollView* scrollView, UIView* zoomingView, CGFloat scale);

/**
 *  equal to -> |scrollViewDidZoom:|
 */
@property (nonatomic, copy) void (^blockForDidZoom)(UIScrollView* scrollView);

/**
 *  equal to -> |scrollViewDidEndScrollingAnimation:|
 */
@property (nonatomic, copy) void (^blockForDidEndScrollingAnimation)(UIScrollView* scrollView);

@end
