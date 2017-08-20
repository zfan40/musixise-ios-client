//
//  MYThirdManager.m
//  Pods
//
//  Created by wmy on 16/10/16.
//
//

#import "MYThirdManager.h"
#import <MYUtils/MYDubugLog.h>
#import "MYThirdWeiboManager.h"


@implementation MYThirdManager

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    //TODO: wmy 需要判断是否是某个sdk可以响应
    return [[MYThirdWeiboManager sharedInstance] handleUrl:url];
}

- (void)loginWithType:(MYThirdKitType)type {
    switch (type) {
        case MYThirdKitType_QQ:
            
            break;
        case MYThirdKitType_Weibo:{
            [[MYThirdWeiboManager sharedInstance] loginWithCallback:^(BOOL success,NSError *error) {
                DebugLog(@"success = %d",success);
            }];
        }
            break;
        case MYThirdKitType_Weichat:
            
            break;
    }
}

- (void)shareWithType:(MYThirdKitType)type shareContent:(id<MYShareModelProtocol>)shareModel {
    //TODO: wmy
}

- (void)setup {
    //1. 注册微博
    [[MYThirdWeiboManager sharedInstance] setup];
}

@end
