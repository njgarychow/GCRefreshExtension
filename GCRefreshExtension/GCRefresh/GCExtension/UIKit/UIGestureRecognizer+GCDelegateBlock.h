//
//  UIGestureRecognizer+GCDelegateBlock.h
//  GCExtension
//
//  Created by zhoujinqiang on 14-9-10.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIGestureRecognizer (GCDelegateBlock)

/**
 *  equal to -> |gestureRecognizerShouldBegin:|
 */
@property (nonatomic, copy) BOOL (^blockForShouldBegin)(UIGestureRecognizer* gesture);

/**
 *  equal to -> |gestureRecognizer:shouldReceiveTouch:|
 */
@property (nonatomic, copy) BOOL (^blockForShouldReceiveTouch)(UIGestureRecognizer* gesture, UITouch* touch);

/**
 *  equal to -> |gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:|
 */
@property (nonatomic, copy) BOOL (^blockForShouldSimultaneous)(UIGestureRecognizer* gesture, UIGestureRecognizer* otherGesture);

/**
 *  equal to -> |gestureRecognizer:shouldRequireFailureOfGestureRecognizer:|
 */
@property (nonatomic, copy) BOOL (^blockForShouldRequireFailureOf)(UIGestureRecognizer* gesture, UIGestureRecognizer* otherGesture) NS_AVAILABLE_IOS(7_0);

/**
 *  equal to -> |gestureRecognizer:shouldBeRequiredToFailByGestureRecognizer:|
 */
@property (nonatomic, copy) BOOL (^blockForShouldBeRequireToFailureBy)(UIGestureRecognizer* gesture, UIGestureRecognizer* otherGesture) NS_AVAILABLE_IOS(7_0);

- (void)usingBlocks;

@end
