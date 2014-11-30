//
//  UIScrollView+GCRefresh.h
//  GCRefreshExtension
//
//  Created by zhoujinqiang on 14/11/27.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCRefreshProtocol.h"

@interface UIScrollView (GCRefresh)

/**
 *  invoke to trigger the refresh function.
 */
- (void)usingRefresh;

/**
 *  the showing header view when refreshing
 */
@property (nonatomic, strong) UIView<GCRefreshProtocol>* headerRefreshView;
/**
 *  Set the action when the header refresh is triggered. Or nil if you want to 
 *  remove the header refresh function.
 *
 *  @param headerRefreshAction  The action will be invoke when the header refresh triggered.
 */
- (void)setHeaderRefreshAction:(void (^)())headerRefreshAction;
/**
 *  Trigger the header refresh.
 *
 *  @param animation    The refresh with an animation or not.
 */
- (void)startHeaderRefreshWithAnimation:(BOOL)animation;
/**
 *  End the header refresh. You must invoke this method when the header refresh is end.
 */
- (void)endHeaderRefresh;


/**
 *  the showing footer view when refreshing
 */
@property (nonatomic, strong) UIView<GCRefreshProtocol>* footerRefreshView;
/**
 *  Set the action when the footer refresh is triggered. Or nil if you want to
 *  remove the footer refresh function.
 *
 *  @param footerRefreshAction  The action will be invoke when the footer refresh triggered.
 */
- (void)setFooterRefreshAction:(void (^)())footerRefreshAction;
/**
 *  Trigger the footer refresh.
 *
 *  @param animation    The refresh with an animation or not.
 */
- (void)startFooterRefreshWithAnimation:(BOOL)animation;
/**
 *  End the footer refresh. You must invoke this method when the footer refresh is end.
 */
- (void)endFooterRefresh;

@end
