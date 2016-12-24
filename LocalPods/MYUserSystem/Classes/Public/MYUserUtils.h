//
//  MYUserUtils.h
//  Pods
//
//  Created by wmy on 16/9/28.
//
// 用于存放user信息的参数

#import <MYUtils/MYBasicSingleton.h>
#import "MYUser.h"

#define MYUserDidChanged @"MYUserDidChanged"

@interface MYUserUtils : MYBasicSingleton

@property(nonatomic, strong) MYUser *user;

- (NSString *)userName;
- (long long)userId;
//TODO: wmy 登录或者修改用户信息后需要调用更新用户信息的接口
- (void)updateUser:(MYUser *)user;

@end
