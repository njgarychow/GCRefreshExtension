//
//  UITextView+GCDelegateBlock.m
//  GCExtension
//
//  Created by zhoujinqiang on 14/11/14.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "UITextView+GCDelegateBlock.h"
#import "NSObject+GCAccessor.h"
#import "UITextViewDelegateImplementationProxy.h"

#import <objc/runtime.h>



@implementation UITextView (GCDelegateBlock)

- (void)usingBlocks {
    static char implementKey;
    UITextViewDelegateImplementationProxy* implement = objc_getAssociatedObject(self, &implementKey);
    if (!implement) {
        implement = [[UITextViewDelegateImplementationProxy alloc] init];
        implement.owner = self;
        objc_setAssociatedObject(self, &implementKey, implement, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    self.delegate = (id)implement;
}

+ (void)load {
    [self extensionAccessorGenerator];
}

@dynamic blockForShouldBeginEditing;
@dynamic blockForDidBeginEditing;
@dynamic blockForShouldEndEditing;
@dynamic blockForDidEndEditing;
@dynamic blockForShouldChangeText;
@dynamic blockForDidChanged;
@dynamic blockForDidChangeSelection;
@dynamic blockForShouldInteractAttachment;
@dynamic blockForShouldInteractURL;

+ (NSArray *)extensionAccessorNonatomicCopyPropertyNames {
    return @[@"blockForShouldBeginEditing",
             @"blockForDidBeginEditing",
             @"blockForShouldEndEditing",
             @"blockForDidEndEditing",
             @"blockForShouldChangeText",
             @"blockForDidChanged",
             @"blockForDidChangeSelection",
             @"blockForShouldInteractAttachment",
             @"blockForShouldInteractURL"];
}

@end
