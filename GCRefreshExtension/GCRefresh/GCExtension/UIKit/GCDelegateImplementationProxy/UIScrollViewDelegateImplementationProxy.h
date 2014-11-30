//
//  UIScrollViewDelegateImplementationProxy.h
//  GCExtension
//
//  Created by zhoujinqiang on 14-10-14.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface UIScrollViewDelegateImplementation : NSObject <UIScrollViewDelegate>

@end







@interface UIScrollViewDelegateImplementationProxy : NSProxy

@property (nonatomic, weak) UIScrollView* owner;

- (id)init;

@end
