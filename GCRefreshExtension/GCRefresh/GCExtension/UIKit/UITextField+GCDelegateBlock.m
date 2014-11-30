//
//  UITextField+GCDelegateBlock.m
//  GCExtension
//
//  Created by zhoujinqiang on 14-10-14.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "UITextField+GCDelegateBlock.h"
#import "NSObject+GCAccessor.h"
#import "UITextFieldDelegateImplementationProxy.h"
#import <objc/runtime.h>

@implementation UITextField (GCDelegateBlock)

static char UITextFieldDelegateImplementationProxyKey;
- (void)usingBlocks {
    UITextFieldDelegateImplementationProxy* proxy = objc_getAssociatedObject(self, &UITextFieldDelegateImplementationProxyKey);
    if (!proxy) {
        proxy = [[UITextFieldDelegateImplementationProxy alloc] init];
        proxy.owner = self;
        objc_setAssociatedObject(self, &UITextFieldDelegateImplementationProxyKey, proxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    self.delegate = (id)proxy;
}


@dynamic blockForShouldBeginEditing;
@dynamic blockForDidBeginEditing;
@dynamic blockForShouldEndEditing;
@dynamic blockForDidEndEditing;
@dynamic blockForShouldReplacementString;
@dynamic blockForShouldClear;
@dynamic blockForShouldReturn;

+ (void)load {
    [self extensionAccessorGenerator];
}

+ (NSArray *)extensionAccessorNonatomicCopyPropertyNames {
    return @[@"blockForShouldBeginEditing",
             @"blockForDidBeginEditing",
             @"blockForShouldEndEditing",
             @"blockForDidEndEditing",
             @"blockForShouldReplacementString",
             @"blockForShouldClear",
             @"blockForShouldReturn"];
}

@end
