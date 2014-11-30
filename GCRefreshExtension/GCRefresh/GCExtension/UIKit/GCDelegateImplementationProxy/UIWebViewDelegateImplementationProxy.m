//
//  UIWebViewDelegateImplementationProxy.m
//  GCExtension
//
//  Created by njgarychow on 11/7/14.
//  Copyright (c) 2014 zhoujinqiang. All rights reserved.
//

#import "UIWebViewDelegateImplementationProxy.h"

#import "UIWebView+GCDelegateBlock.h"

@interface UIWebViewDelegateImplementation : NSObject <UIWebViewDelegate>

@end


@implementation UIWebViewDelegateImplementation

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return webView.blockForShouldStartLoadRequest(webView, request, navigationType);
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    webView.blockForDidStartLoad(webView);
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    webView.blockForDidFinishLoad(webView);
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    webView.blockForDidFailLoad(webView, error);
}

@end







@interface UIWebViewDelegateImplementationProxy ()

@property (nonatomic, strong) UIWebViewDelegateImplementation* realObject;

@end

@implementation UIWebViewDelegateImplementationProxy

- (instancetype)init {
    _realObject = [[UIWebViewDelegateImplementation alloc] init];
    return self;
}

#define BlockStatementTest(statement) do { if (statement) { return YES; } } while (0)
#define Statement(selectorString, block) (block && [selectorString isEqualToString:targetSelectorString])
#define BlockStatement(block, selectorString) BlockStatementTest(Statement(selectorString, block))

- (BOOL)respondsToSelector:(SEL)aSelector {
    NSString* targetSelectorString = NSStringFromSelector(aSelector);
    
    /**
     *  BlcokStatement expand:
     *  if (|block| && [|selectorString| isEqualToString:targetSelectorString]) {
     *      return YES;
     *  }
     */
    BlockStatement(self.owner.blockForShouldStartLoadRequest, @"webView:shouldStartLoadWithRequest:navigationType:");
    BlockStatement(self.owner.blockForDidStartLoad, @"webViewDidStartLoad:");
    BlockStatement(self.owner.blockForDidFinishLoad, @"webViewDidFinishLoad:");
    BlockStatement(self.owner.blockForDidFailLoad, @"webView:didFailLoadWithError:");
    
    return NO;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [_realObject methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:_realObject];
}

- (void)dealloc {
    if (self == self.owner.delegate) {
        self.owner.delegate = nil;
    }
}

@end
