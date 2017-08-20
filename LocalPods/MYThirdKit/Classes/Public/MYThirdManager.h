//
//  MYThirdManager.h
//  Pods
//
//  Created by wmy on 16/10/16.
//
//  三方库对外接口，只能调用此manager

#import <MYUtils/MYBasicSingleton.h>
#import "MYThirdConstants.h"
#import "MYShareModelProtocol.h"

@interface MYThirdManager : MYBasicSingleton

- (void)setup;
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

/**
 * 根据type登录
 */
- (void)loginWithType:(MYThirdKitType)type;


- (void)shareWithType:(MYThirdKitType)type shareContent:(id<MYShareModelProtocol>)shareModel;


@end
