//
//  NSObject+GCAccessor.m
//  GCExtension
//
//  Created by njgarychow on 9/21/14.
//  Copyright (c) 2014 zhoujinqiang. All rights reserved.
//

#import "NSObject+GCAccessor.h"

#import <objc/runtime.h>

@interface GCExtensionAccessorWrapper : NSObject

@property (nonatomic, strong) id nonatomic_strong_property;
@property (nonatomic, weak) id nonatomic_weak_property;
@property (nonatomic, copy) id nonatomic_copy_property;
@property (atomic, strong) id atomic_strong_property;
@property (atomic, weak) id atomic_weak_property;
@property (atomic, copy) id atomic_copy_property;

@end

@implementation GCExtensionAccessorWrapper

@end













@implementation NSObject (GCAccessor)
- (NSMutableDictionary *)properties {
    static char const PropertyDictionaryKey;
    NSMutableDictionary* propertiesDic = objc_getAssociatedObject(self, &PropertyDictionaryKey);
    if (!propertiesDic) {
        propertiesDic = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, &PropertyDictionaryKey, propertiesDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return propertiesDic;
}
- (void)_setPropertyThroughoutSelector:(SEL)selector property:(id)property {
    NSString* propertyKey = getPropertiesKeyStringWithGetOrSetSelector(selector);
    if (property) {
        [[self properties] setObject:property forKey:propertyKey];
    }
    else {
        [[self properties] removeObjectForKey:propertyKey];
    }
}
- (id)_getPropertyThroughoutSelector:(SEL)selector {
    NSString* blockKey = getPropertiesKeyStringWithGetOrSetSelector(selector);
    return [[self properties] objectForKey:blockKey];
}
static inline NSString * getPropertiesKeyStringWithGetOrSetSelector(SEL selector) {
    NSString* selectorName = [NSStringFromSelector(selector) lowercaseString];
    return [selectorName
            stringByReplacingOccurrencesOfString:@"(^set|:)"
            withString:@""
            options:NSRegularExpressionSearch
            range:NSMakeRange(0, [selectorName length])];
}
static inline void nonatomic_strong_setter(id self, SEL _cmd, id property) {
    GCExtensionAccessorWrapper* wrapper = [[GCExtensionAccessorWrapper alloc] init];
    wrapper.nonatomic_strong_property = property;
    [self _setPropertyThroughoutSelector:_cmd property:wrapper];
}
static inline id nonatomic_strong_getter(id self, SEL _cmd) {
    GCExtensionAccessorWrapper* wrapper = [self _getPropertyThroughoutSelector:_cmd];
    return wrapper.nonatomic_strong_property;
}
static inline void nonatomic_copy_setter(id self, SEL _cmd, id property) {
    GCExtensionAccessorWrapper* wrapper = [[GCExtensionAccessorWrapper alloc] init];
    wrapper.nonatomic_copy_property = property;
    [self _setPropertyThroughoutSelector:_cmd property:wrapper];
}
static inline id nonatomic_copy_getter(id self, SEL _cmd) {
    GCExtensionAccessorWrapper* wrapper = [self _getPropertyThroughoutSelector:_cmd];
    return wrapper.nonatomic_copy_property;
}
static inline void nonatomic_weak_setter(id self, SEL _cmd, id property) {
    GCExtensionAccessorWrapper* wrapper = [[GCExtensionAccessorWrapper alloc] init];
    wrapper.nonatomic_weak_property = property;
    [self _setPropertyThroughoutSelector:_cmd property:wrapper];
}
static inline id nonatomic_weak_getter(id self, SEL _cmd) {
    GCExtensionAccessorWrapper* wrapper = [self _getPropertyThroughoutSelector:_cmd];
    return wrapper.nonatomic_weak_property;
}
static inline void atomic_strong_setter(id self, SEL _cmd, id property) {
    GCExtensionAccessorWrapper* wrapper = [[GCExtensionAccessorWrapper alloc] init];
    wrapper.atomic_strong_property = property;
    [self _setPropertyThroughoutSelector:_cmd property:wrapper];
}
static inline id atomic_strong_getter(id self, SEL _cmd) {
    GCExtensionAccessorWrapper* wrapper = [self _getPropertyThroughoutSelector:_cmd];
    return wrapper.atomic_strong_property;
}
static inline void atomic_copy_setter(id self, SEL _cmd, id property) {
    GCExtensionAccessorWrapper* wrapper = [[GCExtensionAccessorWrapper alloc] init];
    wrapper.atomic_copy_property = property;
    [self _setPropertyThroughoutSelector:_cmd property:wrapper];
}
static inline id atomic_copy_getter(id self, SEL _cmd) {
    GCExtensionAccessorWrapper* wrapper = [self _getPropertyThroughoutSelector:_cmd];
    return wrapper.atomic_copy_property;
}
static inline void atomic_weak_setter(id self, SEL _cmd, id property) {
    GCExtensionAccessorWrapper* wrapper = [[GCExtensionAccessorWrapper alloc] init];
    wrapper.atomic_weak_property = property;
    [self _setPropertyThroughoutSelector:_cmd property:wrapper];
}
static inline id atomic_weak_getter(id self, SEL _cmd) {
    GCExtensionAccessorWrapper* wrapper = [self _getPropertyThroughoutSelector:_cmd];
    return wrapper.atomic_weak_property;
}
static inline SEL propertyGetterSelector(NSString* propertyString) {
    return NSSelectorFromString(propertyString);
}
static inline SEL propertySetterSelector(NSString* propertyString) {
    NSString* head = [propertyString substringToIndex:1];
    NSString* rest = [propertyString substringFromIndex:1];
    return NSSelectorFromString([NSString stringWithFormat:@"set%@%@:", [head uppercaseString], rest]);
};

+ (void)extensionAccessorGeneratorWithProperties:(NSArray *)properties
                                          setter:(IMP)setter
                                          getter:(IMP)getter {
    
    for (NSString* propertyString in properties) {
        SEL getterSEL = propertyGetterSelector(propertyString);
        SEL setterSEL = propertySetterSelector(propertyString);
        class_addMethod(self, setterSEL, (IMP)(setter), "v@:@");
        class_addMethod(self, getterSEL, (IMP)(getter), "@@:");
    }
}




+ (void)load {
    [self extensionAccessorGenerator];
}

+ (void)extensionAccessorGenerator {
    [self extensionAccessorGeneratorWithProperties:[self extensionAccessorNonatomicStrongPropertyNames]
                                            setter:(IMP)(nonatomic_strong_setter)
                                            getter:(IMP)(nonatomic_strong_getter)];

    [self extensionAccessorGeneratorWithProperties:[self extensionAccessorNonatomicCopyPropertyNames]
                                            setter:(IMP)(nonatomic_copy_setter)
                                            getter:(IMP)(nonatomic_copy_getter)];
    
    [self extensionAccessorGeneratorWithProperties:[self extensionAccessorNonatomicWeakPropertyNames]
                                            setter:(IMP)(nonatomic_weak_setter)
                                            getter:(IMP)(nonatomic_weak_getter)];
    
    [self extensionAccessorGeneratorWithProperties:[self extensionAccessorAtomicStrongPropertyNames]
                                            setter:(IMP)(atomic_strong_setter)
                                            getter:(IMP)(atomic_strong_getter)];
    
    [self extensionAccessorGeneratorWithProperties:[self extensionAccessorAtomicCopyPropertyNames]
                                            setter:(IMP)(atomic_copy_setter)
                                            getter:(IMP)(atomic_copy_getter)];
    
    [self extensionAccessorGeneratorWithProperties:[self extensionAccessorAtomicWeakPropertyNames]
                                            setter:(IMP)(atomic_weak_setter)
                                            getter:(IMP)(atomic_weak_getter)];
}

+ (NSArray *)extensionAccessorNonatomicStrongPropertyNames {
    return @[];
}
+ (NSArray *)extensionAccessorNonatomicCopyPropertyNames {
    return @[];
}
+ (NSArray *)extensionAccessorNonatomicWeakPropertyNames {
    return @[];
}

+ (NSArray *)extensionAccessorAtomicStrongPropertyNames {
    return @[];
}
+ (NSArray *)extensionAccessorAtomicCopyPropertyNames {
    return @[];
}
+ (NSArray *)extensionAccessorAtomicWeakPropertyNames {
    return @[];
}

@end
