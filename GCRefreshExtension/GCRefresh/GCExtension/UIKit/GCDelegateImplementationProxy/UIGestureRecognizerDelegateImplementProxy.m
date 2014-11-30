//
//  UIGestureRecognizerDelegateImplementProxy.m
//  GCExtension
//
//  Created by zhoujinqiang on 14-10-14.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "UIGestureRecognizerDelegateImplementProxy.h"

#import "UIGestureRecognizer+GCDelegateBlock.h"


@interface UIGestureRecognizerDelegateImplement : NSObject <UIGestureRecognizerDelegate>

@property (nonatomic, weak) UIGestureRecognizer* owner;

@end

@implementation UIGestureRecognizerDelegateImplement

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return gestureRecognizer.blockForShouldBegin(gestureRecognizer);
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return gestureRecognizer.blockForShouldReceiveTouch(gestureRecognizer, touch);
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return gestureRecognizer.blockForShouldSimultaneous(gestureRecognizer, otherGestureRecognizer);
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return gestureRecognizer.blockForShouldBeRequireToFailureBy(gestureRecognizer, otherGestureRecognizer);
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return gestureRecognizer.blockForShouldRequireFailureOf(gestureRecognizer, otherGestureRecognizer);
}

@end




@interface UIGestureRecognizerDelegateImplementProxy ()

@property (nonatomic, strong) UIGestureRecognizerDelegateImplement* realObject;

@end

@implementation UIGestureRecognizerDelegateImplementProxy

- (id)init {
    self.realObject = [[UIGestureRecognizerDelegateImplement alloc] init];
    return self;
}

#define BlockStatementTest(statement) do { if (statement) { return YES; } } while (0)
#define Statement(block, selectorString) (block && [selectorString isEqualToString:targetSelectorString])
#define BlockStatement(block, selectorString) BlockStatementTest(Statement(block, selectorString))
- (BOOL)respondsToSelector:(SEL)aSelector {
    NSString* targetSelectorString = NSStringFromSelector(aSelector);
    
    BlockStatement(self.owner.blockForShouldBegin, @"gestureRecognizerShouldBegin:");
    BlockStatement(self.owner.blockForShouldReceiveTouch, @"gestureRecognizer:shouldReceiveTouch:");
    BlockStatement(self.owner.blockForShouldSimultaneous, @"gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:");
    BlockStatement(self.owner.blockForShouldRequireFailureOf, @"gestureRecognizer:shouldRequireFailureOfGestureRecognizer:");
    BlockStatement(self.owner.blockForShouldBeRequireToFailureBy, @"gestureRecognizer:shouldBeRequiredToFailByGestureRecognizer");
    
    return NO;
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.realObject methodSignatureForSelector:sel];
}
- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.realObject];
}

@end
