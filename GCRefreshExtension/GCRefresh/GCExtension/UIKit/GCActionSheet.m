//
//  GCActionSheet.m
//  GCExtension
//
//  Created by njgarychow on 14-8-18.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "GCActionSheet.h"

#import "GCMacro.h"


@interface GCActionSheetButtonWrapper : NSObject

@property (nonatomic, strong, readonly) NSString* title;
@property (nonatomic, strong, readonly) void (^actionBlock)();

- (instancetype)initWithTitle:(NSString *)title actionBlock:(void (^)())actionBlock;

@end

@implementation GCActionSheetButtonWrapper

- (instancetype)initWithTitle:(NSString *)title actionBlock:(void (^)())actionBlock {
    if (self = [self init]) {
        _title = title;
        _actionBlock = actionBlock;
    }
    return self;
}

@end










@interface GCActionSheet () <UIActionSheetDelegate>

@property (nonatomic, strong) UIActionSheet* actionSheet;

@property (nonatomic, strong) NSString* title;

@property (nonatomic, strong) GCActionSheetButtonWrapper* cancelWrapper;
@property (nonatomic, strong) GCActionSheetButtonWrapper* destructiveWarpper;
@property (nonatomic, strong) NSMutableArray* otherWappers;

@end

@implementation GCActionSheet

- (id)initWithFrame:(CGRect)frame {
    NSAssert(NO, @"use |initWithTitle:message:| instead.");
    return nil;
}

- (id)initWithTitle:(NSString *)title {
    if (self = [super initWithFrame:CGRectZero]) {
        _title = title;
        
        _otherWappers = [NSMutableArray array];
    }
    return self;
}

- (void)setCancelButtonTitle:(NSString *)title actionBlock:(void (^)())action {
    _cancelWrapper = [[GCActionSheetButtonWrapper alloc] initWithTitle:title actionBlock:action];
}
- (void)setDestructiveButtonTitle:(NSString *)title actionBlock:(void (^)())action {
    _destructiveWarpper = [[GCActionSheetButtonWrapper alloc] initWithTitle:title actionBlock:action];
}
- (void)addOtherButtonTitle:(NSString *)title actionBlock:(void (^)())action {
    [_otherWappers addObject:[[GCActionSheetButtonWrapper alloc] initWithTitle:title actionBlock:action]];
}


- (void)showInView:(UIView *)view {
    NSParameterAssert(_actionSheet.isVisible == NO);
    
    GCRetain(self);
    
    _actionSheet = [[UIActionSheet alloc] init];
    _actionSheet.delegate = self;
    
    if (_destructiveWarpper) {
        [_actionSheet addButtonWithTitle:_destructiveWarpper.title];
        _actionSheet.destructiveButtonIndex = _actionSheet.numberOfButtons - 1;
    }
    
    for (GCActionSheetButtonWrapper* otherWrapper in _otherWappers) {
        [_actionSheet addButtonWithTitle:otherWrapper.title];
    }
    
    if (_cancelWrapper) {
        [_actionSheet addButtonWithTitle:_cancelWrapper.title];
        _actionSheet.cancelButtonIndex = _actionSheet.numberOfButtons - 1;
    }
    
    
    [_actionSheet showInView:view];
}


#pragma mark - UIActionSheet delegate methods

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        GCBlockInvoke(_cancelWrapper.actionBlock);
    }
    else if (buttonIndex == actionSheet.destructiveButtonIndex) {
        GCBlockInvoke(_destructiveWarpper.actionBlock);
    }
    else {
        NSInteger otherButtonIndex = buttonIndex;
        if (actionSheet.destructiveButtonIndex != -1) {
            otherButtonIndex = buttonIndex - 1;
        }
        GCActionSheetButtonWrapper* otherWrapper = _otherWappers[otherButtonIndex];
        GCBlockInvoke(otherWrapper.actionBlock);
    }
    
    GCRelease(self);
}

@end
