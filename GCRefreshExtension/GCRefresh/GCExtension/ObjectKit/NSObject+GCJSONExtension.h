//
//  NSObject+GCJSONExtension.h
//  GCExtension
//
//  Created by njgarychow on 14-8-25.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (GCJSONExtension)


/**
 *  Create an object from the serailized JSON UTF8 String.
 *
 *  @param JSONString   the JSON String encoded by UTF8
 *
 *  @return     An object of this class. Or An array of objects of this class. Or nil if
 *  the JSONString can't convert to the object.
 */
+ (id)serailizeFromJSONUTF8String:(NSString *)JSONString;
/**
 *  Create an objcet from the JSON Data.
 *
 *  @param JSONData     the JSON data.
 *
 *  @return     An object of this class. Or An array of objects of this class. Or nil if
 *  the JSONData can't convert to the object.
 */
+ (id)serailizeFromJSONData:(NSData *)JSONData;
/**
 *  Create an object from the JSON Object.
 *
 *  @param JSONObject   the JSON Object. It must be one these classes [NSNull, NSString, NSNumber,
 *  NSArray, NSDictionary];
 *
 *  @return     An object of this class. Or An array of objects of this class. Or nil if
 *  the JSONObject can't convert to the object.
 */
+ (id)serailizeFromJSONObject:(id)JSONObject;

/**
 *  This method is abstract. You must override it. You may implements this method
 *  using NSDictionary.
 *
 *  @param key     the JSON key of the serailized object.
 *
 *  @return     the property's name which is map the JSON key.
 *  Or nil if the property has no this JSON key.
 */
+ (NSString *)getPropertyNameForJSONKey:(NSString *)key;
/**
 *  This method is abstract. You must override it. You may implements this method
 *  using NSDictionary.
 *
 *  @param key     the JSON key of the serailzed object.
 *
 *  @return     the container's contents' class type.
 */
+ (Class)getClassForJSONKey:(NSString *)key;


@end
