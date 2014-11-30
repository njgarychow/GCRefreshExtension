//
//  NSObject+GCAccessor.h
//  GCExtension
//
//  Created by njgarychow on 9/21/14.
//  Copyright (c) 2014 zhoujinqiang. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  This extension is for add properties when your extension an exist class.
 *  When you use this Class Extension. You must do some step as follows:
 *  1   invoke the method |extensionAccessorGenerator| in your class's method |+load|.
 *  2   overrid the extensionAccessor... methods. (exclusive |extensionAccessorGenerator|.
 */
@interface NSObject (GCAccessor)


/**
 *  This method must be invoked in method |+load| by yourself.
 */
+ (void)extensionAccessorGenerator;

/**
 *  You must override this method. don't invoke super.
 *
 *  @return The nonatomic strong property's names.
 */
+ (NSArray *)extensionAccessorNonatomicStrongPropertyNames;
/**
 *  You must override this method. don't invoke super.
 *
 *  @return The nonatomic copy property's names.
 */
+ (NSArray *)extensionAccessorNonatomicCopyPropertyNames;
/**
 *  You must override this method. don't invoke super.
 *
 *  @return The nonatomic weak property's names.
 */
+ (NSArray *)extensionAccessorNonatomicWeakPropertyNames;
/**
 *  You must override this method. don't invoke super.
 *
 *  @return The atomic strong property's names.
 */
+ (NSArray *)extensionAccessorAtomicStrongPropertyNames;
/**
 *  You must override this method. don't invoke super.
 *
 *  @return The atomic copy property's names.
 */
+ (NSArray *)extensionAccessorAtomicCopyPropertyNames;
/**
 *  You must override this method. don't invoke super.
 *
 *  @return The atomic weak property's names.
 */
+ (NSArray *)extensionAccessorAtomicWeakPropertyNames;

@end
