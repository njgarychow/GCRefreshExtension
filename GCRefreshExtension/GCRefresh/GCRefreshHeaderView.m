//
//  GCRefreshHeaderView.m
//  GCRefreshExtension
//
//  Created by zhoujinqiang on 14/11/27.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "GCRefreshHeaderView.h"

#define indicateViewCount   5

@interface GCRefreshHeaderView ()

@property (nonatomic, strong) UILabel* promptLabel;
@property (nonatomic, strong) NSArray* indicateViews;
@property (nonatomic, assign) int indicateTimerCounter;
@property (nonatomic, strong) NSTimer* indicateTimer;

@end


@implementation GCRefreshHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.promptLabel = [[UILabel alloc] initWithFrame:self.bounds];
        self.promptLabel.textAlignment = NSTextAlignmentCenter;
        self.promptLabel.textColor = [UIColor grayColor];
        [self addSubview:self.promptLabel];
        [self _resetPromptLabel];
        
        NSMutableArray* views = [NSMutableArray array];
        for (int i = 0; i < indicateViewCount; i++) {
            UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
            view.layer.cornerRadius = 8;
            view.layer.masksToBounds = NO;
            [self addSubview:view];
            [views addObject:view];
        }
        self.indicateViews = [views copy];
        [self _resetIndicateViews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    float leftMargin = (CGRectGetWidth(self.bounds) - (15 * indicateViewCount + 140)) / 2;
    for (int i = 0, j = (int)[self.indicateViews count]; i < j; i++) {
        UIView* view = self.indicateViews[i];
        view.frame = CGRectMake(leftMargin + i * 15, CGRectGetHeight(self.bounds) / 2 - 5, 10, 10);
    }
    
    self.promptLabel.frame = CGRectMake(leftMargin + indicateViewCount * 15, 0, 140, CGRectGetHeight(self.bounds));
}

- (void)refreshFromProgress:(float)fromProgress toProgress:(float)toProgress {
    
    [self _resetIndicateViewsHighlight:MIN(indicateViewCount, (int)(toProgress * indicateViewCount))];
    
    if (toProgress >= 1.0) {
        self.promptLabel.text = @"释放立即刷新";
    }
    if (toProgress < 1.0) {
        self.promptLabel.text = @"继续下拉刷新";
    }
}

- (void)refreshTriggered {
    self.promptLabel.text = @"正在刷新";
    
    self.indicateTimer = [NSTimer
                          scheduledTimerWithTimeInterval:.1f
                          target:self
                          selector:@selector(_refreshingAnimation)
                          userInfo:nil
                          repeats:YES];
}

- (void)refreshEnd {
    self.promptLabel.text = @"刷新完成";
    [self.indicateTimer invalidate];
    self.indicateTimer = nil;
}

- (void)refreshCompleted {
    [self _resetPromptLabel];
    [self _resetIndicateViews];
}

- (void)_refreshingAnimation {
    [self _resetIndicateViewsHighlight:(self.indicateTimerCounter++ % indicateViewCount) + 1];
}

- (void)_resetIndicateViewsHighlight:(int)count {
    [self _resetIndicateViews];
    for (int i = 0, j = count; i < j; i++) {
        UIView* view = self.indicateViews[i];
        view.backgroundColor = [UIColor blueColor];
    }
}

- (void)_resetPromptLabel {
    self.promptLabel.text = @"继续下拉进行刷新";
}
- (void)_resetIndicateViews {
    for (UIView* view in self.indicateViews) {
        view.backgroundColor = [UIColor grayColor];
    }
}

@end
