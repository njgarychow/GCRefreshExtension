//
//  GCRefreshHeaderView.m
//  GCRefreshExtension
//
//  Created by zhoujinqiang on 14/11/27.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "GCRefreshHeaderView.h"

@implementation GCRefreshHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)refreshFromProgress:(float)fromProgress toProgress:(float)toProgress {
    self.backgroundColor = [UIColor colorWithRed:.5f green:.5f blue:.5f alpha:toProgress];
}

- (void)refreshTriggered {
    self.backgroundColor = [UIColor blueColor];
}

- (void)refreshEnd {
    self.backgroundColor = [UIColor redColor];
}

@end
