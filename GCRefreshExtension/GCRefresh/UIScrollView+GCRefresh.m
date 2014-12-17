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

@property (nonatomic, assign) UIEdgeInsets originalContentInset;

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

@dynamic originalContentInset;
static char OriginalContentInsetKey;
- (UIEdgeInsets)originalContentInset {
    return UIEdgeInsetsFromString(objc_getAssociatedObject(self, &OriginalContentInsetKey));
}
- (void)setOriginalContentInset:(UIEdgeInsets)originalContentInset {
    NSString* insetsString = NSStringFromUIEdgeInsets(originalContentInset);
    objc_setAssociatedObject(self, &OriginalContentInsetKey, insetsString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end








@implementation UIScrollView (GCRefresh)



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

@dynamic headerRefreshTriggerHeight;
static char HeaderRefreshTriggerHeightKey;
- (float)headerRefreshTriggerHeight {
    return [objc_getAssociatedObject(self, &HeaderRefreshTriggerHeightKey) floatValue];
}
- (void)setHeaderRefreshTriggerHeight:(float)headerRefreshTriggerHeight {
    [self willChangeValueForKey:@"headerRefreshTriggerHeight"];
    objc_setAssociatedObject(self, &HeaderRefreshTriggerHeightKey, @(headerRefreshTriggerHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"headerRefreshTriggerHeight"];
}



- (void)setHeaderRefreshAction:(void (^)())headerRefreshAction {
    [self setHeaderRefreshActionBlock:headerRefreshAction];
    
    if (headerRefreshAction && !self.headerRefreshView) {
        self.headerRefreshView = [[GCRefreshHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 60)];
        self.headerRefreshView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
    if (!headerRefreshAction && self.headerRefreshView) {
        self.headerRefreshView = nil;
    }
    
    [self _startOrCancelRefreshObserve];
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
         self.contentInset = self.originalContentInset;
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

@dynamic footerRefreshTriggerHeight;
static char FooterRefreshTriggerHeightKey;
- (float)footerRefreshTriggerHeight {
    return [objc_getAssociatedObject(self, &FooterRefreshTriggerHeightKey) floatValue];
}
- (void)setFooterRefreshTriggerHeight:(float)footerRefreshTriggerHeight {
    [self willChangeValueForKey:@"footerRefreshTriggerHeight"];
    objc_setAssociatedObject(self, &FooterRefreshTriggerHeightKey, @(footerRefreshTriggerHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"footerRefreshTriggerHeight"];
}

- (void)setFooterRefreshAction:(void (^)())footerRefreshAction {
    [self setFooterRefreshActionBlock:footerRefreshAction];
    
    if (footerRefreshAction && !self.footerRefreshView) {
        self.footerRefreshView = [[GCRefreshFooterView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 60)];
        self.footerRefreshView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
    if (!footerRefreshAction && self.footerRefreshView) {
        self.footerRefreshView = nil;
    }
    
    [self _startOrCancelRefreshObserve];
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
         self.contentInset = self.originalContentInset;
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
    if (self.headerRefreshTriggerHeight > 0) {
        return self.headerRefreshTriggerHeight;
    }
    return CGRectGetHeight(self.headerRefreshView.bounds);
}
- (float)_footerRefreshTriggerHeight {
    if (self.footerRefreshTriggerHeight > 0) {
        return self.footerRefreshTriggerHeight;
    }
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

- (void)_startOrCancelRefreshObserve {
    [self stopObserveObject:self forKeyPath:@"contentOffset"];
    [self stopObserveObject:self forKeyPath:@"contentSize"];
    
    if (!self.headerRefreshView && !self.footerRefreshView) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    [self startObserveObject:self forKeyPath:@"contentOffset" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        typeof(weakSelf) self = weakSelf;
        
        if (self.isRefreshing) {
            return;
        }
        
        const float old_y = [change[NSKeyValueChangeOldKey] CGPointValue].y;
        const float cur_y = [change[NSKeyValueChangeNewKey] CGPointValue].y;
        if (old_y == cur_y) {
            return;
        }
        
        if ((cur_y + self.contentInset.top) < 0 && self.headerRefreshView) {
            const float oldY = old_y + self.contentInset.top;
            const float y = cur_y + self.contentInset.top;
            const float triggerHeight = [self _headerRefreshTriggerHeight];
            if ([self.headerRefreshView respondsToSelector:@selector(refreshFromProgress:toProgress:)]) {
                [self.headerRefreshView refreshFromProgress:(fabsf(oldY) / triggerHeight) toProgress:(fabsf(y) / triggerHeight)];
            }
            
            float maxY = MAX(fabsf(oldY), fabsf(y));
            if (!self.isDragging && fabsf(maxY) >= triggerHeight) {
                if (self.headerRefreshActionBlock) {
                    self.headerRefreshActionBlock();
                }
                self.isRefreshing = YES;
                if ([self.headerRefreshView respondsToSelector:@selector(refreshTriggered)]) {
                    [self.headerRefreshView refreshTriggered];
                }
                self.originalContentInset = self.contentInset;
                UIEdgeInsets insets = self.originalContentInset;
                insets.top += triggerHeight;
                [UIView animateWithDuration:.3f animations:^{
                    self.contentInset = insets;
                }];
            }
        }
        
        float footerDistance = MAX(CGRectGetHeight(self.bounds), self.contentSize.height);
        if (self.footerRefreshView && (cur_y - self.contentInset.bottom + CGRectGetHeight(self.bounds) > footerDistance)) {
            const float oldY = old_y - self.contentInset.bottom;
            const float y = cur_y - self.contentInset.bottom;
            const float triggerHeight = [self _footerRefreshTriggerHeight];
            if ([self.footerRefreshView respondsToSelector:@selector(refreshFromProgress:toProgress:)]) {
                [self.footerRefreshView refreshFromProgress:(((oldY + CGRectGetHeight(self.bounds)) - footerDistance) / triggerHeight) toProgress:(((y + CGRectGetHeight(self.bounds)) - footerDistance) / triggerHeight)];
            }
            
            float maxY = MAX(fabsf(oldY), fabsf(y));
            if (!self.isDragging && (((maxY + CGRectGetHeight(self.bounds)) - footerDistance) > triggerHeight)) {
                if (self.footerRefreshActionBlock) {
                    self.footerRefreshActionBlock();
                }
                self.isRefreshing = YES;
                if ([self.footerRefreshView respondsToSelector:@selector(refreshTriggered)]) {
                    [self.footerRefreshView refreshTriggered];
                }
                self.originalContentInset = self.contentInset;
                UIEdgeInsets insets = self.originalContentInset;
                insets.bottom += triggerHeight;
                if (self.contentSize.height < CGRectGetHeight(self.bounds)) {
                    insets.bottom += CGRectGetHeight(self.bounds) - self.contentSize.height;
                }
                [UIView animateWithDuration:.3f animations:^{
                    self.contentInset = insets;
                }];
            }
        }
    }];
    
    [self startObserveObject:self forKeyPath:@"contentSize" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        typeof(weakSelf) self = weakSelf;
        
        [self _resetFooterViewFrame];
    }];
}


@end
