//
//  MYWeiboManager.m
//  Pods
//
//  Created by wmy on 16/10/16.
//
//

#import "MYThirdWeiboManager.h"
#import <MYUtils/MYDubugLog.h>
#import "MYThirdConstants.h"
#import "MYThirdWeiboLoginManager.h"
#import "MYWeiBoShareImageModel.h"
#import "MYWeiBoResponseModel.h"
#import "MYWeiBoShareMediaModel.h"
#import "MYMusixiseLoginManager.h"
#import "MYThirdWeiboShareManager.h"
#import "WeiboSDK.h"

@interface MYThirdWeiboManager () 


@end

@implementation MYThirdWeiboManager

- (void)setup {
#if DEBUG
    [WeiboSDK enableDebugMode:YES];
#endif
    [WeiboSDK registerApp:kWeiboAppKey];
}

- (BOOL)handleUrl:(NSURL *)url {
    return [WeiboSDK handleOpenURL:url delegate:[MYThirdWeiboLoginManager sharedInstance]];
}

- (void)loginWithCallback:(LoginCallback)callback {
    [[MYThirdWeiboLoginManager sharedInstance] loginWithCallback:callback];
}

//TODO: wmy 该方法应该收到微博分享相关的manager中
- (void)shareWithShareModel:(id<MYShareModelProtocol>)shareModel {
    [[MYThirdWeiboShareManager sharedInstance] shareWithShareModel:shareModel];
}

@end
