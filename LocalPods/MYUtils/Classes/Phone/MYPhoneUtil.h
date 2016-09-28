//
//  MYPhoneUtil.h
//  xiaplay
//
//  Created by wmy on 15/11/25.
//  Copyright © 2015年 wmy. All rights reserved.
//  获取手机的各种信息

#import "MYBasicSingleton.h"

@interface MYPhoneUtil : MYBasicSingleton
/**
 *  获取app的版本信息
 *
 *  @return 手机版本
 */
- (NSString *)version;
/**
 *  获取app的名称
 *
 *  @return app的名称
 */
- (NSString *)appName;
/**
 *   获取app的build版本号
 *
 *  @return build版本号
 */
- (NSString *)buildVersion;
/**
 *  获取设备的id
 *
 *  @return device_id
 */
- (NSString *)deviceId;
- (NSString *)deviceName;

@end
