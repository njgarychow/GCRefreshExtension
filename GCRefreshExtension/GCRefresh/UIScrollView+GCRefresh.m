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
#import "GCRefreshFooterView.h"
#import "GCExtension.h"


@interface UIScrollView (GCRefreshProperty)

@property (nonatomic, copy) void (^headerRefreshActionBlock)();
@property (nonatomic, copy) void (^footerRefreshActionBlock)();
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


@dynamic footerRefreshActionBlock;
static char footerRefreshActionBlockKey;
- (void (^)())footerRefreshActionBlock {
    return objc_getAssociatedObject(self, &footerRefreshActionBlockKey);
}
- (void)setFooterRefreshActionBlock:(void (^)())footerRefreshActionBlock {
    [self willChangeValueForKey:@"footerRefreshActionBlock"];
    objc_setAssociatedObject(self, &footerRefreshActionBlockKey, footerRefreshActionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:@"footerRefreshActionBlock"];
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

- (void)usingRefresh {
    [self stopObserveObject:self forKeyPath:@"contentOffset"];
    [self stopObserveObject:self forKeyPath:@"contentSize"];
    
    __weak typeof(self) weakSelf = self;
    [self startObserveObject:self forKeyPath:@"contentOffset" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        
        if (self.isRefreshing) {
            return;
        }
        
        float oldY = [change[NSKeyValueChangeOldKey] CGPointValue].y;
        float y = [change[NSKeyValueChangeNewKey] CGPointValue].y;
        if (oldY == y) {
            return;
        }
        
        if (y < 0 && weakSelf.headerRefreshView) {
            const float triggerHeight = [weakSelf _headerRefreshTriggerHeight];
            if ([weakSelf.headerRefreshView respondsToSelector:@selector(refreshFromProgress:toProgress:)]) {
                [weakSelf.headerRefreshView refreshFromProgress:(fabsf(oldY) / triggerHeight) toProgress:(fabsf(y) / triggerHeight)];
            }
            
            float maxY = MAX(fabsf(oldY), fabsf(y));
            if (!weakSelf.isDragging && fabsf(maxY) >= triggerHeight) {
                if (weakSelf.headerRefreshActionBlock) {
                    weakSelf.headerRefreshActionBlock();
                }
                weakSelf.isRefreshing = YES;
                if ([weakSelf.headerRefreshView respondsToSelector:@selector(refreshTriggered)]) {
                    [weakSelf.headerRefreshView refreshTriggered];
                }
                [UIView animateWithDuration:0.3f animations:^{
                    weakSelf.contentInset = UIEdgeInsetsMake(triggerHeight, 0, 0, 0);
                }];
            }
        }
        
        float footerDistance = MAX(CGRectGetHeight(weakSelf.bounds), weakSelf.contentSize.height);
        if (weakSelf.footerRefreshView && (y + CGRectGetHeight(weakSelf.bounds) > footerDistance)) {
            const float triggerHeight = [weakSelf _footerRefreshTriggerHeight];
            if ([weakSelf.footerRefreshView respondsToSelector:@selector(refreshFromProgress:toProgress:)]) {
                [weakSelf.footerRefreshView refreshFromProgress:(((oldY + CGRectGetHeight(weakSelf.bounds)) - footerDistance) / triggerHeight) toProgress:(((y + CGRectGetHeight(weakSelf.bounds)) - footerDistance) / triggerHeight)];
            }
            
            float maxY = MAX(fabsf(oldY), fabsf(y));
            if (!weakSelf.isDragging && (((maxY + CGRectGetHeight(weakSelf.bounds)) - footerDistance) > triggerHeight)) {
                if (weakSelf.footerRefreshActionBlock) {
                    weakSelf.footerRefreshActionBlock();
                }
                weakSelf.isRefreshing = YES;
                if ([weakSelf.footerRefreshView respondsToSelector:@selector(refreshTriggered)]) {
                    [weakSelf.footerRefreshView refreshTriggered];
                }
                [UIView animateWithDuration:0.3f animations:^{
                    weakSelf.contentInset = UIEdgeInsetsMake(0, 0, triggerHeight, 0);
                }];
            }
        }
    }];
    
    [self startObserveObject:self forKeyPath:@"contentSize" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        
        [weakSelf _resetFooterViewFrame];
    }];
}



#pragma mark - header refresh

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
    
    [self willChangeValueForKey:@"headerRefreshView"];
    objc_setAssociatedObject(self, &HeaderRefreshViewCharKey, headerRefreshView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"headerRefreshView"];
    
    if (headerRefreshView) {
        [self addSubview:headerRefreshView];
        headerRefreshView.frame = CGRectMake(0,
                                             -CGRectGetHeight(headerRefreshView.bounds),
                                             CGRectGetWidth(self.bounds),
                                             CGRectGetHeight(headerRefreshView.bounds));
    }
}



- (void)setHeaderRefreshAction:(void (^)())headerRefreshAction {
    [self setHeaderRefreshActionBlock:headerRefreshAction];
    
    if (headerRefreshAction && !self.headerRefreshView) {
        self.headerRefreshView = [[GCRefreshHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 60)];
    }
    if (!headerRefreshAction && self.headerRefreshView) {
        self.headerRefreshView = nil;
    }
}


- (void)startHeaderRefreshWithAnimation:(BOOL)animation {
    if (self.isRefreshing) {
        return;
    }
    if (!self.headerRefreshView) {
        return;
    }
    
    [UIView
     animateWithDuration:(animation ? .3f : 0)
     animations:^{
         self.contentOffset = CGPointMake(0, -[self _headerRefreshTriggerHeight]);
     }];
}
- (void)endHeaderRefresh {
    if (!self.isRefreshing) {
        return;
    }
    if (!self.headerRefreshView) {
        return;
    }
    
    if ([self.headerRefreshView respondsToSelector:@selector(refreshEnd)]) {
        [self.headerRefreshView refreshEnd];
    }
    [UIView
     animateWithDuration:0.3f
     delay:0.1f
     options:0
     animations:^{
         self.contentInset = UIEdgeInsetsZero;
     }
     completion:^(BOOL finished) {
         self.isRefreshing = NO;
         if ([self.headerRefreshView respondsToSelector:@selector(refreshCompleted)]) {
             [self.headerRefreshView refreshCompleted];
         }
     }];
    
}


#pragma mark - footer refresh

@dynamic footerRefreshView;
static char footerRefreshViewKey;
- (UIView<GCRefreshProtocol> *)footerRefreshView {
    return objc_getAssociatedObject(self, &footerRefreshViewKey);
}
- (void)setFooterRefreshView:(UIView<GCRefreshProtocol> *)footerRefreshView {
    UIView* oldFooterView = objc_getAssociatedObject(self, &footerRefreshViewKey);
    if (oldFooterView.superview == self) {
        [oldFooterView removeFromSuperview];
    }
    
    [self willChangeValueForKey:@"footerRefreshView"];
    objc_setAssociatedObject(self, &footerRefreshViewKey, footerRefreshView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"footerRefreshView"];
    
    if (footerRefreshView) {
        [self addSubview:footerRefreshView];
        [self _resetFooterViewFrame];
    }
}

- (void)setFooterRefreshAction:(void (^)())footerRefreshAction {
    [self setFooterRefreshActionBlock:footerRefreshAction];
    
    if (footerRefreshAction && !self.footerRefreshView) {
        self.footerRefreshView = [[GCRefreshFooterView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 60)];
    }
    if (!footerRefreshAction && self.footerRefreshView) {
        self.footerRefreshView = nil;
    }
}

- (void)startFooterRefreshWithAnimation:(BOOL)animation {
    if (self.isRefreshing) {
        return;
    }
    if (!self.footerRefreshView) {
        return;
    }
    
    [UIView
     animateWithDuration:(animation ? .3f : 0)
     animations:^{
         self.contentOffset = CGPointMake(0, [self _footerRefreshTriggerYOffset]);
     }];
}

- (void)endFooterRefresh {
    if (!self.isRefreshing) {
        return;
    }
    if (!self.footerRefreshView) {
        return;
    }
    
    if ([self.footerRefreshView respondsToSelector:@selector(refreshEnd)]) {
        [self.footerRefreshView refreshEnd];
    }
    [UIView
     animateWithDuration:0.3f
     delay:0.1f
     options:0
     animations:^{
         self.contentInset = UIEdgeInsetsZero;
     }
     completion:^(BOOL finished) {
         [self _resetFooterViewFrame];
         self.isRefreshing = NO;
         if ([self.footerRefreshView respondsToSelector:@selector(refreshCompleted)]) {
             [self.footerRefreshView refreshCompleted];
         }
     }];
}





#pragma mark - private method

- (float)_headerRefreshTriggerHeight {
    return CGRectGetHeight(self.headerRefreshView.bounds);
}
- (float)_footerRefreshTriggerHeight {
    return CGRectGetHeight(self.footerRefreshView.bounds);
}
- (float)_footerRefreshTriggerYOffset {
    float height = MAX(CGRectGetHeight(self.bounds), self.contentSize.height);
    height += [self _footerRefreshTriggerHeight];
    return height;
}

- (void)_resetFooterViewFrame {
    float y = MAX(CGRectGetHeight(self.bounds), self.contentSize.height);
    CGRect frame = self.footerRefreshView.frame;
    frame.origin.y = y;
    self.footerRefreshView.frame = frame;
}


@end
