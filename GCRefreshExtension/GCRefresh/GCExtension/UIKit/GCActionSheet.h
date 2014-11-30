//
//  GCActionSheet.h
//  GCExtension
//
//  Created by njgarychow on 14-8-18.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCActionSheet : UIView

- (id)initWithTitle:(NSString *)title;

- (void)setCancelButtonTitle:(NSString *)title actionBlock:(void (^)())action;
- (void)setDestructiveButtonTitle:(NSString *)title actionBlock:(void (^)())action;
- (void)addOtherButtonTitle:(NSString *)title actionBlock:(void (^)())action;

- (void)showInView:(UIView *)view;

@end
