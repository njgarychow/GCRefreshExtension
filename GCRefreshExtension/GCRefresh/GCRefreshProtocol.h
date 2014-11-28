//
//  GCRefreshProtocol.h
//  GCRefreshExtension
//
//  Created by zhoujinqiang on 14/11/27.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GCRefreshProtocol <NSObject>

@optional
- (void)refreshFromProgress:(float)fromProgress toProgress:(float)toProgress;
- (void)refreshTriggered;
- (void)refreshEnd;

@end
