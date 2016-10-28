//
//  MYThirdManager.h
//  Pods
//
//  Created by wmy on 16/10/16.
//
//

#import <MYUtils/MYBasicSingleton.h>

@interface MYThirdManager : MYBasicSingleton

- (void)setup;
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

@end
