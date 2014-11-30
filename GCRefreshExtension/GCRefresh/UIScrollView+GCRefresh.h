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

- (void)usingRefresh;

@property (nonatomic, strong) UIView<GCRefreshProtocol>* headerRefreshView;
- (void)setHeaderRefreshAction:(void (^)())headerRefreshAction;
- (void)startHeaderRefreshWithAnimation:(BOOL)animation;
- (void)endHeaderRefresh;

@property (nonatomic, strong) UIView<GCRefreshProtocol>* footerRefreshView;
- (void)setFooterRefreshAction:(void (^)())footerRefreshAction;
- (void)startFooterRefreshWithAnimation:(BOOL)animation;
- (void)endFooterRefresh;

@end
