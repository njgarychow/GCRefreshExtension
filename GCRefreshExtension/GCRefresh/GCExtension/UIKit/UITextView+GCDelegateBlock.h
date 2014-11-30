//
//  UITextView+GCDelegateBlock.h
//  GCExtension
//
//  Created by zhoujinqiang on 14/11/14.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (GCDelegateBlock)

- (void)usingBlocks;

/**
 *  equal to -> |textViewShouldBeginEditing:|
 */
@property (nonatomic, copy) BOOL (^blockForShouldBeginEditing)(UITextView* textView);

/**
 *  equal to -> |textViewDidBeginEditing:|
 */
@property (nonatomic, copy) void (^blockForDidBeginEditing)(UITextView* textView);

/**
 *  equal to -> |textViewShouldEndEditing:|
 */
@property (nonatomic, copy) BOOL (^blockForShouldEndEditing)(UITextView* textView);

/**
 *  equal to -> |textViewDidEndEditing:|
 */
@property (nonatomic, copy) void (^blockForDidEndEditing)(UITextView* textView);

/**
 *  equal to -> |textView:shouldChangeTextInRange:replacementText:|
 */
@property (nonatomic, copy) BOOL (^blockForShouldChangeText)(UITextView* textView, NSRange range, NSString* text);

/**
 *  equal to -> |textViewDidChange:|
 */
@property (nonatomic, copy) void (^blockForDidChanged)(UITextView* textView);

/**
 *  equal to -> |textViewDidChangeSelection:|
 */
@property (nonatomic, copy) void (^blockForDidChangeSelection)(UITextView* textView);

/**
 *  equal to -> |textView:shouldInteractWithTextAttachment:inRange:|
 */
@property (nonatomic, copy) BOOL (^blockForShouldInteractAttachment)(UITextView* textView, NSTextAttachment* attachment, NSRange range);

/**
 *  equal to -> |textView:shouldInteractWithURL:inRange:|
 */
@property (nonatomic, copy) BOOL (^blockForShouldInteractURL)(UITextView* textView, NSURL* url, NSRange range);

@end
