//
//  NSObject+GCNotificationObserver.m
//  GCExtension
//
//  Created by njgarychow on 14-8-4.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "NSObject+GCNotificationObserver.h"

#import <objc/runtime.h>


@interface GCNotificationObserverWrapper : NSObject

@property (nonatomic, strong) GCNotificationObserverBlock handleBlock;

- (instancetype)initWithObserverForNotificationName:(NSString *)name handlerBlock:(GCNotificationObserverBlock)block;

@end

@implementation GCNotificationObserverWrapper

- (instancetype)initWithObserverForNotificationName:(NSString *)name handlerBlock:(GCNotificationObserverBlock)block {
    if (self = [self init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(_observerHandlerAction:)
                                                     name:name
                                                   object:nil];
        _handleBlock = block;
    }
    return self;
}

- (void)_observerHandlerAction:(NSNotification *)noti {
    _handleBlock(noti);
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end




@implementation NSObject (GCNotificationObserver)


#pragma mark - class public method
+ (void)addObserverForNotificationName:(NSString *)name usingBlock:(GCNotificationObserverBlock)block {
    NSParameterAssert(name);
    NSParameterAssert(block);
    
    GCNotificationObserverWrapper* wrapper = [[GCNotificationObserverWrapper alloc] initWithObserverForNotificationName:name handlerBlock:block];
    
    [[self _observerWappersForNotificationName:name] addObject:wrapper];
}
+ (void)removeObserverForNotificationName:(NSString *)name {
    NSParameterAssert(name);
    
    [[self _observerWappersForNotificationName:name] removeAllObjects];
}


#pragma mark - class private method
+ (NSMutableArray *)_observerWappersForNotificationName:(NSString *)name {
    static char const observersMapKey;
    NSMutableDictionary* observersMap = objc_getAssociatedObject(self, &observersMapKey);
    if (!observersMap) {
        observersMap = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, &observersMapKey, observersMap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    NSMutableArray* observersArr = observersMap[name];
    if (!observersArr) {
        observersArr = [NSMutableArray array];
        observersMap[name] = observersArr;
    }
    
    return observersArr;
}




#pragma mark - instance public method
- (void)addObserverForNotificationName:(NSString *)name usingBlock:(GCNotificationObserverBlock)block {
    NSParameterAssert(name);
    NSParameterAssert(block);
    
    GCNotificationObserverWrapper* wrapper = [[GCNotificationObserverWrapper alloc] initWithObserverForNotificationName:name handlerBlock:block];
    
    [[self _observerWappersForNotificationName:name] addObject:wrapper];
}
- (void)removeObserverForNotificationName:(NSString *)name {
    NSParameterAssert(name);
    
    [[self _observerWappersForNotificationName:name] removeAllObjects];
}


#pragma mark - instance private method
- (NSMutableArray *)_observerWappersForNotificationName:(NSString *)name {
    static char const observersMapKey;
    NSMutableDictionary* observersMap = objc_getAssociatedObject(self, &observersMapKey);
    if (!observersMap) {
        observersMap = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, &observersMapKey, observersMap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    NSMutableArray* observersArr = observersMap[name];
    if (!observersArr) {
        observersArr = [NSMutableArray array];
        observersMap[name] = observersArr;
    }
    
    return observersArr;
}

@end
