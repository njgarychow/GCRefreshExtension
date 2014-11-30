//
//  UITextFieldDelegateImplementationProxy.m
//  GCExtension
//
//  Created by zhoujinqiang on 14-10-14.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "UITextFieldDelegateImplementationProxy.h"
#import "UITextField+GCDelegateBlock.h"

@interface UITextFieldDelegateImplementation : NSObject <UITextFieldDelegate>

@end

@implementation UITextFieldDelegateImplementation

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return textField.blockForShouldBeginEditing(textField);
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.blockForDidBeginEditing(textField);
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    return textField.blockForShouldEndEditing(textField);
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    textField.blockForDidEndEditing(textField);
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return textField.blockForShouldReplacementString(textField, range, string);
}
- (BOOL)textFieldShouldClear:(UITextField *)textField {
    return textField.blockForShouldClear(textField);
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return textField.blockForShouldReturn(textField);
}

@end






@interface UITextFieldDelegateImplementationProxy()

@property (nonatomic, strong) UITextFieldDelegateImplementation* realObject;

@end




@implementation UITextFieldDelegateImplementationProxy

- (id)init {
    self.realObject = [[UITextFieldDelegateImplementation alloc] init];
    return self;
}

#define BlockStatementTest(statement) do { if (statement) { return YES; } } while (0)
#define Statement(block, selectorString) (block && [selectorString isEqualToString:targetSelectorString])
#define BlockStatement(block, selectorString) BlockStatementTest(Statement(block, selectorString))
- (BOOL)respondsToSelector:(SEL)aSelector {
    NSString* targetSelectorString = NSStringFromSelector(aSelector);
    
    BlockStatement(self.owner.blockForShouldBeginEditing, @"textFieldShouldBeginEditing:");
    BlockStatement(self.owner.blockForDidBeginEditing, @"textFieldDidBeginEditing:");
    BlockStatement(self.owner.blockForShouldEndEditing, @"textFieldShouldEndEditing:");
    BlockStatement(self.owner.blockForDidEndEditing, @"textFieldDidEndEditing:");
    BlockStatement(self.owner.blockForShouldReplacementString, @"textField:shouldChangeCharactersInRange:replacementString:");
    BlockStatement(self.owner.blockForShouldClear, @"textFieldShouldClear:");
    BlockStatement(self.owner.blockForShouldReturn, @"textFieldShouldReturn:");
    
    return NO;
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.realObject methodSignatureForSelector:sel];
}
- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.realObject];
}

@end

