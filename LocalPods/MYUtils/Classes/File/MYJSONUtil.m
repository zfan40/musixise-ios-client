//
//  MYJSONUtil.m
//  Pods
//
//  Created by wmy on 16/6/3.
//
//

#import "MYJSONUtil.h"
#import "MYSafeUtil.h"

@implementation MYJSONUtil

- (NSArray *)arrayWithJSONFilePath:(NSString *)filePath forKey:(NSString *)key{
    NSMutableArray *resultArray = [NSMutableArray array];
    NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                  options:NSJSONReadingMutableContainers
                                                    error:&error];
    if (!isEmptyString(key)) {
        resultArray = [dict objectForKey:key];
    } else {
        if ([dict isKindOfClass:[NSArray class]]) {
            [resultArray addObjectsFromArray:(NSArray *)dict];
        }
    }
    return (NSArray *)resultArray;
}

- (NSDictionary *)dictionaryWithJSONFilePath:(NSString *)filePath forKey:(NSString *)key {
    NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
    NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingMutableContainers
                                                           error:&error];
    if (!isEmptyString(key)) {
        resultDict = [dict objectForKey:key];
    } else {
        if ([dict isKindOfClass:[NSDictionary class]]) {
            [resultDict addEntriesFromDictionary:dict];
        }
    }
    return (NSDictionary *)resultDict;
}


@end
