//
//  UITextField+GCDelegateBlock.h
//  GCExtension
//
//  Created by zhoujinqiang on 14-10-14.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (GCDelegateBlock)

- (void)usingBlocks;

/**
 *  equal to -> |textFieldShouldBeginEditing:|
 */
@property (nonatomic, copy) BOOL (^blockForShouldBeginEditing)(UITextField* textField);

/**
 *  equal to -> |textFieldDidBeginEditing:|
 */
@property (nonatomic, copy) void (^blockForDidBeginEditing)(UITextField* textField);

/**
 *  equal to -> |textFieldShouldEndEditing:|
 */
@property (nonatomic, copy) BOOL (^blockForShouldEndEditing)(UITextField* textField);

/**
 *  equal to -> |textFieldDidEndEditing:|
 */
@property (nonatomic, copy) void (^blockForDidEndEditing)(UITextField* textField);

/**
 *  equal to -> |textField:shouldChangeCharactersInRange:replacementString:|
 */
@property (nonatomic, copy) BOOL (^blockForShouldReplacementString)(UITextField* textField, NSRange range, NSString* replacementString);

/**
 *  equal to -> |textFieldShouldClear:|
 */
@property (nonatomic, copy) BOOL (^blockForShouldClear)(UITextField* textField);

/**
 *  equal to -> |textFieldShouldReturn:|
 */
@property (nonatomic, copy) BOOL (^blockForShouldReturn)(UITextField* textField);

@end
