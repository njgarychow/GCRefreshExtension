//
//  UITextFieldDelegateImplementationProxy.h
//  GCExtension
//
//  Created by zhoujinqiang on 14-10-14.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UITextFieldDelegateImplementationProxy : NSProxy

@property (nonatomic, weak) UITextField* owner;

- (id)init;

@end
