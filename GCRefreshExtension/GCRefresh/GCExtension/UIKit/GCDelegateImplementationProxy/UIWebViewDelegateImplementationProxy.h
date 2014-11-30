//
//  UIWebViewDelegateImplementationProxy.h
//  GCExtension
//
//  Created by njgarychow on 11/7/14.
//  Copyright (c) 2014 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebViewDelegateImplementationProxy : NSProxy

@property (nonatomic, weak) UIWebView* owner;

- (instancetype)init;

@end
