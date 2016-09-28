//
//  NSMutableDictionary+SafeOperationOfDictionary.h
//  TTPod
//
//  Created by chaoyang.zhang on 14-2-18.
//
//

#import <Foundation/Foundation.h>

/**
 *  NSMutableDictionary+SafeOperationOfDictionary.h等类似的实现，提供一组安全地访问容器的方式，避免set nil或者remove nil时的crash。
 */

@interface NSMutableDictionary (ALMSafeOperationOfDictionary)

@end
