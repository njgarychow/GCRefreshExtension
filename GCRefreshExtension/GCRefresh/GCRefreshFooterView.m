//
//  GCRefreshFooterView.m
//  GCRefreshExtension
//
//  Created by njgarychow on 11/28/14.
//  Copyright (c) 2014 zhoujinqiang. All rights reserved.
//

#import "GCRefreshFooterView.h"
#import "RMIndicatorView.h"

@interface GCRefreshFooterView ()

@property (nonatomic, strong) UILabel* promptLabel;
@property (nonatomic, strong) RMIndicatorView* refreshIndicatorView;
@property (nonatomic, strong) UIActivityIndicatorView* indicatorView;

@end


@implementation GCRefreshFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.promptLabel = [[UILabel alloc] init];
        self.promptLabel.textAlignment = NSTextAlignmentCenter;
        self.promptLabel.textColor = [UIColor grayColor];
        [self addSubview:self.promptLabel];
        
        self.refreshIndicatorView = [[RMIndicatorView alloc] initWithFrame:CGRectZero type:kRMMixedIndictor];
        [self.refreshIndicatorView setBackgroundColor:[UIColor whiteColor]];
        [self.refreshIndicatorView setFillColor:[UIColor grayColor]];
        [self.refreshIndicatorView setStrokeColor:[UIColor grayColor]];
        [self.refreshIndicatorView setClosedIndicatorBackgroundStrokeColor:[UIColor grayColor]];
        [self addSubview:self.refreshIndicatorView];
        
        self.indicatorView = [[UIActivityIndicatorView alloc] init];
        self.indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [self addSubview:self.indicatorView];
        
        [self _reset];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    float leftMargin = (CGRectGetWidth(self.bounds) - (40 + 140)) / 2;
    
    self.refreshIndicatorView.frame = CGRectMake(leftMargin, 10, 40, 40);
    self.indicatorView.frame = CGRectMake(leftMargin, 10, 40, 40);
    self.promptLabel.frame = CGRectMake(leftMargin + 40, 0, 140, CGRectGetHeight(self.bounds));
}

- (void)refreshFromProgress:(float)fromProgress toProgress:(float)toProgress {
    
    if (toProgress >= 1.0) {
        self.promptLabel.text = @"释放立即刷新";
    }
    if (toProgress < 1.0) {
        self.promptLabel.text = @"继续上拉刷新";
    }
    [self.refreshIndicatorView updateWithProgress:toProgress];
}

- (void)refreshTriggered {
    self.promptLabel.text = @"正在刷新";
    
    self.refreshIndicatorView.hidden = YES;
    self.indicatorView.hidden = NO;
    [self.indicatorView startAnimating];
}

- (void)refreshEnd {
    self.promptLabel.text = @"刷新完成";
}

- (void)refreshCompleted {
    [self _reset];
}

- (void)_reset {
    self.promptLabel.text = @"继续上拉进行刷新";
    
    self.refreshIndicatorView.hidden = NO;
    
    self.indicatorView.hidden = YES;
    [self.indicatorView stopAnimating];
}

@end
