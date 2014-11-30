//
//  UITextViewDelegateImplementationProxy.m
//  GCExtension
//
//  Created by zhoujinqiang on 14/11/14.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "UITextViewDelegateImplementationProxy.h"
#import "UITextView+GCDelegateBlock.h"



@interface UITextViewDelegateImplementation : UIScrollViewDelegateImplementation <UITextViewDelegate>


@end

@implementation UITextViewDelegateImplementation

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    return textView.blockForShouldBeginEditing(textView);
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    textView.blockForDidBeginEditing(textView);
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    return textView.blockForShouldEndEditing(textView);
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    textView.blockForDidEndEditing(textView);
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    return textView.blockForShouldChangeText(textView, range, text);
}

- (void)textViewDidChange:(UITextView *)textView {
    textView.blockForDidChanged(textView);
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    textView.blockForDidChangeSelection(textView);
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange {
    return textView.blockForShouldInteractAttachment(textView, textAttachment, characterRange);
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    return textView.blockForShouldInteractURL(textView, URL, characterRange);
}

@end




@interface UITextViewDelegateImplementationProxy ()

@property (nonatomic, strong) UITextViewDelegateImplementation* realObject;

@end

@implementation UITextViewDelegateImplementationProxy

- (instancetype)init {
    _realObject = [[UITextViewDelegateImplementation alloc] init];
    return self;
}

#define BlockStatementTest(statement) do { if (statement) { return YES; } } while (0)
#define Statement(selectorString, block) (block && [selectorString isEqualToString:targetSelectorString])
#define BlockStatement(block, selectorString) BlockStatementTest(Statement(selectorString, block))

- (BOOL)respondsToSelector:(SEL)aSelector {
    NSString* targetSelectorString = NSStringFromSelector(aSelector);
    
    /**
     *  BlcokStatement expand:
     *  if (|block| && [|selectorString| isEqualToString:targetSelectorString]) {
     *      return YES;
     *  }
     */
    BlockStatement(self.owner.blockForShouldBeginEditing, @"textViewShouldBeginEditing:");
    BlockStatement(self.owner.blockForDidBeginEditing, @"textViewDidBeginEditing:");
    BlockStatement(self.owner.blockForShouldEndEditing, @"textViewShouldEndEditing:");
    BlockStatement(self.owner.blockForDidEndEditing, @"textViewDidEndEditing:");
    BlockStatement(self.owner.blockForShouldChangeText, @"textView:shouldChangeTextInRange:replacementText:");
    BlockStatement(self.owner.blockForDidChanged, @"textViewDidChange:");
    BlockStatement(self.owner.blockForDidChangeSelection, @"textViewDidChangeSelection:");
    BlockStatement(self.owner.blockForShouldInteractAttachment, @"textView:shouldInteractWithTextAttachment:inRange:");
    BlockStatement(self.owner.blockForShouldInteractURL, @"textView:shouldInteractWithURL:inRange:");
    
    return [super respondsToSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [_realObject methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:_realObject];
}

- (void)dealloc {
    if (self == self.owner.delegate) {
        self.owner.delegate = nil;
    }
}

@end
