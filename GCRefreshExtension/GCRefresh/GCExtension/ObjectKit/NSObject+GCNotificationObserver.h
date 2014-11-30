//
//  NSObject+GCNotificationObserver.h
//  GCExtension
//
//  Created by njgarychow on 14-8-4.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^GCNotificationObserverBlock)(NSNotification* notification);

/**
 *  This Extension is used for add a observe of notificationcenter using Block.
 *  Also after we add the observer to the notificationcenter using the method 
 *  |addObserverForName:usingBlock:|, we don't have to remove the observer when 
 *  |self| is dealloc.
 */
@interface NSObject (GCNotificationObserver)

/**
 *  add class |self| to observe the notification named |name|. The |block| will be invoked when
 *  the notification is posted.
 *
 *  @param name     the name of the notification which want to be observed. |name| can't be nil.
 *  @param block    |block| is the callback when the notification is posted. |block| can't be nil.
 */
+ (void)addObserverForNotificationName:(NSString *)name usingBlock:(GCNotificationObserverBlock)block;

/**
 *  remove class |self| to observe the notifications those named |name|.
 *
 *  @param name     the name of the notification which want to stop observing. |name| can't be nil.
 */
+ (void)removeObserverForNotificationName:(NSString *)name;

/**
 *  add |self| to observe the notification named |name|. The |block| will be invoked when
 *  the notification is posted.
 *
 *  @param name     the name of the notification which want to be observed. |name| can't be nil.
 *  @param block    |block| is the callback when the notification is posted. |block| can't be nil.
 */
- (void)addObserverForNotificationName:(NSString *)name usingBlock:(GCNotificationObserverBlock)block;

/**
 *  remove |self| to observe the notifications those named |name|.
 *
 *  @param name     the name of the notification which want to stop observing. |name| can't be nil.
 */
- (void)removeObserverForNotificationName:(NSString *)name;

@end
