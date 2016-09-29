//
//  MYLoginManager.m
//  musixise
//
//  Created by wmy on 16/9/28.
//  Copyright © 2016年 wmy. All rights reserved.
//

#import "MYLoginManager.h"
#import <WeiboSDK/WeiboSDK.h>
#import <MYUtils/MYDubugLog.h>
#import "MYWeiBoResponseModel.h"
#import "MYMusixiseLoginManager.h"

@interface MYLoginManager () <WeiboSDKDelegate>

@end

@implementation MYLoginManager

- (instancetype)init {
    self = [super init];
    if (self) {
        // 注册微博appKey
        [WeiboSDK registerApp:kWeiboAppKey];
    }
    return self;
}

- (void)loginWithType:(MYLoginType)type {
    switch (type) {
        case MYLoginType_QQ: {
        }
            break;
        case MYLoginType_Weibo: {
            [self loginWithWeibo];
        }
            break;
        case MYLoginType_Taobao: {
        }
            break;
        case MYLoginType_Weixin: {
            
        }
            break;
        case MYLoginType_Normal: {
            
        }
            break;
    }
}

- (void)loginWithWeibo {
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kWeiboAddressRedictURI;
    request.scope = @"all";
    [WeiboSDK sendRequest:request];
}

- (BOOL)handleWithURL:(NSString *)url {
    BOOL res = [WeiboSDK handleOpenURL:url delegate:self];
    if (res) {
        DebugLog(@"");
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
            DebugLog(@"");
        }];
    }
}


@end
