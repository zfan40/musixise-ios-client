//
//  MYJSONUtil.h
//  Pods
//
//  Created by wmy on 16/6/3.
//
//

#import <Foundation/Foundation.h>
#import "MYBasicSingleton.h"

@interface MYJSONUtil : MYBasicSingleton

- (NSArray *)arrayWithJSONFilePath:(NSString *)filePath forKey:(NSString *)key;
- (NSDictionary *)dictionaryWithJSONFilePath:(NSString *)filePath forKey:(NSString *)key;

@end
