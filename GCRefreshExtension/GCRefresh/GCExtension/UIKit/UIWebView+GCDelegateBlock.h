//
//  UIWebView+GCDelegateBlock.h
//  GCExtension
//
//  Created by njgarychow on 11/7/14.
//  Copyright (c) 2014 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (GCDelegateBlock)

- (void)usingBlocks;

/**
 *  equal to -> |webView:shouldStartLoadWithRequest:navigationType:|
 */
@property (nonatomic, copy) BOOL (^blockForShouldStartLoadRequest)(UIWebView* webView, NSURLRequest* request, UIWebViewNavigationType type);

/**
 *  equal to -> |webViewDidStartLoad:|
 */
@property (nonatomic, copy) void (^blockForDidStartLoad)(UIWebView* webView);

/**
 *  equal to -> |webViewDidFinishLoad:|
 */
@property (nonatomic, copy) void (^blockForDidFinishLoad)(UIWebView* webView);

/**
 *  equal to -> |webView:didFailLoadWithError:|
 */
@property (nonatomic, copy) void (^blockForDidFailLoad)(UIWebView* webView, NSError* error);

@end
