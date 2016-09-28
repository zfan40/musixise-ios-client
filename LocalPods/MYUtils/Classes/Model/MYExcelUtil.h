//
//  MYExcelUtil.h
//  Pods
//
//  Created by wmy on 16/6/16.
//
//

#import <Foundation/Foundation.h>

@interface MYExcelUtil : NSObject

+ (NSDictionary<NSString *,NSArray *> *)dictionaryModelPropertyWithFile:(NSString *)file;

@end
