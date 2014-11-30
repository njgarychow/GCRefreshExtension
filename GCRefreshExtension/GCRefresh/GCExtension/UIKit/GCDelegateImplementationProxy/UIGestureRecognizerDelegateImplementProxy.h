//
//  UIGestureRecognizerDelegateImplementProxy.h
//  GCExtension
//
//  Created by zhoujinqiang on 14-10-14.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIGestureRecognizerDelegateImplementProxy : NSProxy

@property (nonatomic, weak) UIGestureRecognizer* owner;

- (id)init;

@end
