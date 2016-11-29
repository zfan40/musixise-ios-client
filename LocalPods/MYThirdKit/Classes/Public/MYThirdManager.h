//
//  MYThirdManager.h
//  Pods
//
//  Created by wmy on 16/10/16.
//
//  三方库对外接口，只能调用此manager

#import <MYUtils/MYBasicSingleton.h>
#import "MYThirdConstants.h"

@interface MYThirdManager : MYBasicSingleton

- (void)setup;
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

/**
 *
 */
- (void)loginWithType:(MYThirdKitType)type;

@end
