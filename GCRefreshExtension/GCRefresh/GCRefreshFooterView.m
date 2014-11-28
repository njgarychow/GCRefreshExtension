//
//  GCRefreshFooterView.m
//  GCRefreshExtension
//
//  Created by njgarychow on 11/28/14.
//  Copyright (c) 2014 zhoujinqiang. All rights reserved.
//

#import "GCRefreshFooterView.h"

@implementation GCRefreshFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)refreshFromProgress:(float)fromProgress toProgress:(float)toProgress {
    self.backgroundColor = [UIColor colorWithRed:.5f green:.5f blue:.5f alpha:toProgress];
    NSLog(@"%f", toProgress);
}

- (void)refreshTriggered {
    self.backgroundColor = [UIColor blueColor];
}

- (void)refreshEnd {
    self.backgroundColor = [UIColor redColor];
}

@end
