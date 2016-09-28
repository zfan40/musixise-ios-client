//
//  MYUserDefault.h
//  xiaplay
//
//  Created by wmy on 15/11/25.
//  Copyright © 2015年 wmy. All rights reserved.
//  存储轻量级本地数据

#import "MYBasicSingleton.h"
#import "MYFileConst.h"
#import "MYSafeUtil.h"

@interface MYUserDefaultUtil : MYBasicSingleton
/**
 *  保存integer数据
 *
 *  @param data Integer数据
 *  @param key  key
 */
- (void)safeIntegerData:(NSInteger)data forKey:(nonnull NSString *)key;
/**
 *  获取Integer数据
 *
 *  @param key key
 *
 *  @return Integer数据
 */
- (NSInteger)integerDataForKey:(nonnull NSString *)key;
/**
 *  保存bool数据
 *
 *  @param data bool数据
 *  @param key  key
 */
- (void)safeBOOLData:(BOOL)data forKey:(nonnull NSString *)key;
/**
 *  获取bool数据
 *
 *  @param data bool数据
 *  @param key  key
 */
- (BOOL)boolDataForKey:(nonnull NSString *)key;
/**
 *  保存NSString数据
 *
 *  @param data String数据
 *  @param key  key
 *
 */
- (void)safeStringData:(nonnull NSString *)data forKey:(nonnull NSString *)key;
/**
 *  获取NSString数据
 *
 *  @param key key
 *
 *  @return String数据
 */
- (nonnull NSString *)stringDataForKey:(nonnull NSString *)key;

- (void)safeObject:(NSObject *)obj forKey:(NSString *)key;
- (NSObject *)objectForKey:(NSString *)key;
@end
