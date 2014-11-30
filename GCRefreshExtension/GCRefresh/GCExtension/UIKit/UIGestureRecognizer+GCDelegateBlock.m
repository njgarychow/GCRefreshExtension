//
//  UIGestureRecognizer+GCDelegateBlock.m
//  GCExtension
//
//  Created by zhoujinqiang on 14-9-10.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "UIGestureRecognizer+GCDelegateBlock.h"

#import "GCMacro.h"
#import "NSObject+GCAccessor.h"
#import "UIGestureRecognizerDelegateImplementProxy.h"














@interface UIGestureRecognizer (GCDelegateBlockProperty)
@property (nonatomic, strong) UIGestureRecognizerDelegateImplementProxy* implement;
@end

@implementation UIGestureRecognizer (GCDelegateBlockProperty)
@dynamic implement;
@end


@implementation UIGestureRecognizer (GCDelegateBlock)

- (void)usingBlocks {
    if (!self.implement) {
        self.implement = [[UIGestureRecognizerDelegateImplementProxy alloc] init];
        self.implement.owner = self;
    }
    self.delegate = (id)self.implement;
}


@dynamic blockForShouldBegin;
@dynamic blockForShouldReceiveTouch;
@dynamic blockForShouldSimultaneous;
@dynamic blockForShouldRequireFailureOf;
@dynamic blockForShouldBeRequireToFailureBy;


+ (void)load {
    [self extensionAccessorGenerator];
}

+ (NSArray *)extensionAccessorNonatomicCopyPropertyNames {
    return @[@"blockForShouldBegin",
             @"blockForShouldReceiveTouch",
             @"blockForShouldSimultaneous",
             @"blockForShouldRequireFailureOf",
             @"blockForShouldBeRequireToFailureBy"];
}

+ (NSArray *)extensionAccessorNonatomicStrongPropertyNames {
    return @[@"implement"];
}

@end
