//
//  MYThirdManager.m
//  Pods
//
//  Created by wmy on 16/10/16.
//
//

#import "MYThirdManager.h"
#import "MYWeiboManager.h"

@implementation MYThirdManager

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    //TODO: wmy 需要判断是否是某个sdk可以响应
    return [WeiboSDK handleOpenURL:url delegate:[MYWeiboManager sharedInstance]];
}

- (void)setup {
    //1. 注册微博
    [[MYWeiboManager sharedInstance] setup];
}

@end
