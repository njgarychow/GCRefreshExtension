//
//  UIWebView+GCDelegateBlock.m
//  GCExtension
//
//  Created by njgarychow on 11/7/14.
//  Copyright (c) 2014 zhoujinqiang. All rights reserved.
//

#import "UIWebView+GCDelegateBlock.h"

#import "NSObject+GCAccessor.h"
#import "UIWebViewDelegateImplementationProxy.h"
#import <objc/runtime.h>

@implementation UIWebView (GCDelegateBlock)

- (void)usingBlocks {
    static char WebViewDelegateImplementationProxyKey;
    UIWebViewDelegateImplementationProxy* webViewDelegate = objc_getAssociatedObject(self, &WebViewDelegateImplementationProxyKey);
    if (!webViewDelegate) {
        webViewDelegate = [[UIWebViewDelegateImplementationProxy alloc] init];
        webViewDelegate.owner = self;
        objc_setAssociatedObject(self, &WebViewDelegateImplementationProxyKey, webViewDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    self.delegate = (id)webViewDelegate;
}


@dynamic blockForShouldStartLoadRequest;
@dynamic blockForDidStartLoad;
@dynamic blockForDidFinishLoad;
@dynamic blockForDidFailLoad;

+ (void)load {
    [self extensionAccessorGenerator];
}

+ (NSArray *)extensionAccessorNonatomicCopyPropertyNames {
    return @[@"blockForShouldStartLoadRequest",
             @"blockForDidStartLoad",
             @"blockForDidFinishLoad",
             @"blockForDidFailLoad"];
}

@end
