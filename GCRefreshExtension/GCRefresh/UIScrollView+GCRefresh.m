//
//  UIScrollView+GCRefresh.m
//  GCRefreshExtension
//
//  Created by zhoujinqiang on 14/11/27.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "UIScrollView+GCRefresh.h"

#import <objc/runtime.h>

#import "GCRefreshHeaderView.h"


@interface UIScrollView (GCRefreshProperty)

@property (nonatomic, copy) void (^headerRefreshActionBlock)();
@property (nonatomic, assign) BOOL isRefreshing;

@end


@implementation UIScrollView (GCRefreshProperty)

@dynamic headerRefreshActionBlock;
static char headerRefreshActionBlockKey;
- (void (^)())headerRefreshActionBlock {
    return objc_getAssociatedObject(self, &headerRefreshActionBlockKey);
}
- (void)setHeaderRefreshActionBlock:(void (^)())headerRefreshActionBlock {
    [self willChangeValueForKey:@"headerRefreshActionBlock"];
    objc_setAssociatedObject(self, &headerRefreshActionBlockKey, headerRefreshActionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:@"headerRefreshActionBlock"];
}

@dynamic isRefreshing;
static char isRefreshingKey;
- (BOOL)isRefreshing {
    return [objc_getAssociatedObject(self, &isRefreshingKey) boolValue];
}
- (void)setIsRefreshing:(BOOL)isRefreshing {
    objc_setAssociatedObject(self, &isRefreshingKey, @(isRefreshing), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end








@implementation UIScrollView (GCRefresh)

@dynamic headerRefreshView;
static char HeaderRefreshViewCharKey;
- (UIView<GCRefreshProtocol> *)headerRefreshView {
    return objc_getAssociatedObject(self, &HeaderRefreshViewCharKey);
}
- (void)setHeaderRefreshView:(UIView<GCRefreshProtocol> *)headerRefreshView {
    UIView* oldHeaderRefreshView = objc_getAssociatedObject(self, &HeaderRefreshViewCharKey);
    if (oldHeaderRefreshView.superview == self) {
        [oldHeaderRefreshView removeFromSuperview];
    }
    if (headerRefreshView) {
        [self addSubview:headerRefreshView];
        headerRefreshView.frame = CGRectMake(0,
                                             -CGRectGetHeight(headerRefreshView.bounds),
                                             CGRectGetWidth(self.bounds),
                                             CGRectGetHeight(headerRefreshView.bounds));
    }
    [self willChangeValueForKey:@"headerRefreshView"];
    objc_setAssociatedObject(self, &HeaderRefreshViewCharKey, headerRefreshView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"headerRefreshView"];
}



- (void)usingRefresh {
    [self addObserver:self
           forKeyPath:@"contentOffset"
              options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
              context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if (self.isRefreshing) {
        return;
    }
    
    float oldY = [change[NSKeyValueChangeOldKey] CGPointValue].y;
    float y = [change[NSKeyValueChangeNewKey] CGPointValue].y;
    if (oldY == y) {
        return;
    }
    
    if (y < 0 && self.headerRefreshView) {
        const float triggerHeight = [self _headerRefreshTriggerHeight];
        if ([self.headerRefreshView respondsToSelector:@selector(refreshFromProgress:toProgress:)]) {
            [self.headerRefreshView refreshFromProgress:(fabsf(oldY) / triggerHeight) toProgress:(fabsf(y) / triggerHeight)];
        }
        
        if (!self.isDragging && fabsf(y) >= triggerHeight) {
            if (self.headerRefreshActionBlock) {
                self.headerRefreshActionBlock();
            }
            self.isRefreshing = YES;
            if ([self.headerRefreshView respondsToSelector:@selector(refreshTriggered)]) {
                [self.headerRefreshView refreshTriggered];
            }
            [UIView animateWithDuration:0.3f animations:^{
                self.contentInset = UIEdgeInsetsMake(triggerHeight, 0, 0, 0);
            }];
        }
    }
}


- (void)setHeaderRefreshAction:(void (^)())headerRefreshAction {
    [self setHeaderRefreshActionBlock:headerRefreshAction];
    
    if (headerRefreshAction && !self.headerRefreshView) {
        self.headerRefreshView = [[GCRefreshHeaderView alloc] initWithFrame:CGRectMake(0, -60, CGRectGetWidth(self.bounds), 60)];
    }
    if (!headerRefreshAction && self.headerRefreshView) {
        self.headerRefreshView = nil;
    }
}


- (void)startHeaderRefresh {
    self.contentOffset = CGPointMake(0, -[self _headerRefreshTriggerHeight]);
}
- (void)endHeaderRefresh {
    self.isRefreshing = NO;
    [self.headerRefreshView refreshEnd];
    [UIView animateWithDuration:0.3f
                          delay:0.1f
                        options:0
                     animations:^{
                         self.contentInset = UIEdgeInsetsZero;
                     }
                     completion:nil];
    
}





#pragma mark - private method

- (float)_headerRefreshTriggerHeight {
    return CGRectGetHeight(self.headerRefreshView.bounds);
}


@end
