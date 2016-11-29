//
//  MYLoginManager.h
//  Pods
//
//  Created by wmy on 2016/11/1.
//
//  登录的接口 （外层的登录都以此进行访问）

#import <MYUtils/MYBasicSingleton.h>
#import "MYLoginConstants.h"
#import "MYUserUtils.h"

@interface MYLoginManager : MYBasicSingleton 

/**
 * 登录接口
 */
- (void)loginWithType:(MYLoginType)type userName:(NSString *)name password:(NSString* )password loginCallback:(LoginCallback)callback;
// 需要整理的两个方法
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;
- (BOOL)handleWithURL:(NSString *)url;
@end
