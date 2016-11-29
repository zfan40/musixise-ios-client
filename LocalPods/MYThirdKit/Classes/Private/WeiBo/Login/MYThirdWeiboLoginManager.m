//
//  MYLoginManager.m
//  musixise
//
//  Created by wmy on 16/9/28.
//  Copyright © 2016年 wmy. All rights reserved.
//

#import "MYThirdWeiboLoginManager.h"
#import "WeiboSDK.h"
#import <MYUtils/MYDubugLog.h>
#import "MYWeiBoResponseModel.h"
#import "MYMusixiseLoginManager.h"
#import <MYMVVM/MYRouter.h>

#import "MYThirdWeiboManager.h"

@interface MYThirdWeiboLoginManager () <WeiboSDKDelegate>

@property(nonatomic, copy) LoginCallback callback;

@end

@implementation MYThirdWeiboLoginManager

- (void)loginWithCallback:(LoginCallback)callback {
    [self loginWithWeibo];
    self.callback = callback;
}

- (void)loginWithWeibo {
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kWeiboAddressRedictURI;
    request.scope = @"all";
    [WeiboSDK sendRequest:request];
}

- (BOOL)handleWithURL:(NSString *)url {
    BOOL res = [WeiboSDK handleOpenURL:[NSURL URLWithString:url] delegate:self];
    if (res) {
        DebugLog(@"");
        [router routeUrl:url];
    }
    return res;
}

#pragma mark 微博

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    if ([response isKindOfClass:WBAuthorizeResponse.class]) {
        WBAuthorizeResponse *aResp = (WBAuthorizeResponse *)response;
        MYWeiBoResponseModel *weiboModel = [[MYWeiBoResponseModel alloc] init];
        weiboModel.userId = aResp.userID;
        weiboModel.accessToken = aResp.accessToken;
        weiboModel.refreshToken = aResp.refreshToken;
        weiboModel.expirationDate = aResp.expirationDate;
        // 使用该accessToken来请求native的参数
        [[MYMusixiseLoginManager sharedInstance] musixiseLoginWithType:MYLoginType_Weibo
                                                             withModel:weiboModel
                                                          withCallback:^(NSDictionary *dict, NSError *error) {
                                                              if (self.callback) {
                                                                  self.callback(!error);
                                                              }
        }];
    }
}


@end
