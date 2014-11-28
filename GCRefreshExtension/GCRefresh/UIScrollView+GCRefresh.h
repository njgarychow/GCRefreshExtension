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
- (void)startHeaderRefresh;
- (void)endHeaderRefresh;

@end
