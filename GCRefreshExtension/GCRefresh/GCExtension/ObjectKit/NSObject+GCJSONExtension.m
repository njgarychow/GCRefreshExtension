//
//  NSObject+GCJSONExtension.m
//  GCExtension
//
//  Created by njgarychow on 14-8-25.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "NSObject+GCJSONExtension.h"

#import <objc/runtime.h>


@implementation NSObject (GCJSONExtension)

+ (id)serailizeFromJSONUTF8String:(NSString *)JSONString {
    NSData* JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    return [self serailizeFromJSONData:JSONData];
}
+ (id)serailizeFromJSONData:(NSData *)JSONData {
    id JSONObject = [NSJSONSerialization
                     JSONObjectWithData:JSONData
                     options:NSJSONReadingMutableContainers
                     error:nil];
    
    if (!JSONObject) {
        return nil;
    }
    
    return [self serailizeFromJSONObject:JSONObject];
}

+ (id)serailizeFromJSONObject:(id)JSONObject {
    
    Class JSONObjectClass = [JSONObject class];
    if ([JSONObjectClass isSubclassOfClass:[NSNull class]]) {
        return nil;
    }
    if ([JSONObjectClass isSubclassOfClass:[NSString class]]) {
        return JSONObject;
    }
    if ([JSONObjectClass isSubclassOfClass:[NSNumber class]]) {
        return JSONObject;
    }
    if ([JSONObjectClass isSubclassOfClass:[NSArray class]]) {
        NSMutableArray* array = [NSMutableArray array];
        for (id objectItor in JSONObject) {
            id object = [self serailizeFromJSONObject:objectItor];
            if (object && ![object isKindOfClass:[NSNull class]]) {
                [array addObject:object];
            }
        }
        return array;
    }
    
    if ([JSONObjectClass isSubclassOfClass:[NSDictionary class]]) {
        
        id object = [[self alloc] init];
        
        for (NSString* key in [JSONObject allKeys]) {
            NSString* propertyName = [self getPropertyNameForJSONKey:key];
            propertyName = propertyName ?: key;
            
            if (!class_getProperty(self, [propertyName cStringUsingEncoding:NSUTF8StringEncoding])) {
                continue;
            }
            
            id propertyObject = JSONObject[key];
            if ([propertyObject isKindOfClass:[NSArray class]] ||
                [propertyObject isKindOfClass:[NSDictionary class]]) {
                
                Class cls = [self getClassForJSONKey:key];
                [object setValue:[cls serailizeFromJSONObject:propertyObject] forKey:propertyName];
            }
            else {
                [object setValue:propertyObject forKey:propertyName];
            }
        }
        return object;
    }
    
    return nil;
}

+ (NSString *)getPropertyNameForJSONKey:(NSString *)key {
    NSAssert(NO, @"this method is abstract, you must override it.");
    return nil;
}
+ (Class)getClassForJSONKey:(NSString *)key {
    NSAssert(NO, @"this method is abstract, you must override it.");
    return nil;
}

@end























@interface NSNull (GCJSONExtension)

@end

@implementation NSNull (GCJSONExtension)

+ (NSString *)getPropertyNameForJSONKey:(NSString *)key {
    return nil;
}
+ (Class)getClassForJSONKey:(NSString *)key {
    return self;
}

@end



@interface NSString (GCJSONExtension)

@end

@implementation NSString (GCJSONExtension)

+ (NSString *)getPropertyNameForJSONKey:(NSString *)key {
    return nil;
}
+ (Class)getClassForJSONKey:(NSString *)key {
    return self;
}

@end



@interface NSNumber (GCJSONExtension)

@end

@implementation NSNumber (GCJSONExtension)

+ (NSString *)getPropertyNameForJSONKey:(NSString *)key {
    return nil;
}
+ (Class)getClassForJSONKey:(NSString *)key {
    return self;
}

@end





@interface NSArray (GCJSONExtension)

@end

@implementation NSArray (GCJSONExtension)

+ (NSString *)getPropertyNameForJSONKey:(NSString *)key {
    return nil;
}
+ (Class)getClassForJSONKey:(NSString *)key {
    return self;
}
+ (id)serailizeFromJSONObject:(id)JSONObject {
    return JSONObject;
}

@end



@interface NSDictionary (GCJSONExtension)

@end

@implementation NSDictionary (GCJSONExtension)

+ (NSString *)getPropertyNameForJSONKey:(NSString *)key {
    return nil;
}
+ (Class)getClassForJSONKey:(NSString *)key {
    return self;
}
+ (id)serailizeFromJSONObject:(id)JSONObject {
    return JSONObject;
}

@end