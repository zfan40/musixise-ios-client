//
//  MYUserDefault.m
//  xiaplay
//
//  Created by wmy on 15/11/25.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import "MYUserDefaultUtil.h"

@interface MYUserDefaultUtil ()

@property (nonatomic,strong) NSUserDefaults *userDefaults;

@end

@implementation MYUserDefaultUtil

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------
#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------
#pragma mark - --------------------功能函数------------------

- (void)safeIntegerData:(NSInteger)data forKey:(nonnull NSString *)key {
    [self.userDefaults setObject:@(data) forKey:key];
    [self.userDefaults synchronize];
}

- (NSInteger)integerDataForKey:(nonnull NSString *)key {
    return [self.userDefaults integerForKey:key];
}

- (void)safeBOOLData:(BOOL)data forKey:(nonnull NSString *)key {
    [self.userDefaults setObject:@(data) forKey:key];
    [self.userDefaults synchronize];
}

- (void)safeObject:(NSObject *)obj forKey:(NSString *)key {
    [self.userDefaults setObject:obj forKey:key];
    [self.userDefaults synchronize];
}
- (NSObject *)objectForKey:(NSString *)key {
    return [self.userDefaults objectForKey:key];
}

- (BOOL)boolDataForKey:(nonnull NSString *)key {
    return [self.userDefaults boolForKey:key];
}

- (void)safeStringData:(nonnull NSString *)data forKey:(nonnull NSString *)key {
    [self.userDefaults setObject:data forKey:key];
    [self.userDefaults synchronize];
}

- (NSString *)stringDataForKey:(NSString *)key {
    return [self.userDefaults stringForKey:key];
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

- (NSUserDefaults *)userDefaults {
    if (!_userDefaults) {
        _userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return _userDefaults;
}


@end
