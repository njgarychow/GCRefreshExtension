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
/**
 *  This method is invoked before refresh trigger. It show the progess. You can implement animation with the fromProgress and toProgress.
 *
 *  @param fromProgress The last progress.
 *  @param toProgress   The current progress.
 */
- (void)refreshFromProgress:(float)fromProgress toProgress:(float)toProgress;

/**
 *  The refresh action is triggered.
 */
- (void)refreshTriggered;

/**
 *  The refresh action is end.
 */
- (void)refreshEnd;

/**
 *  The refresh action(Include animation) is completed.
 */
- (void)refreshCompleted;

@end
