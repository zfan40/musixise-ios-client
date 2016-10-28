//
//  MYWeiboManager.m
//  Pods
//
//  Created by wmy on 16/10/16.
//
//

#import "MYWeiboManager.h"
#import <MYUtils/MYDubugLog.h>
#import "MYThirdConstants.h"
#import "MYWeiBoShareImageModel.h"
#import "MYWeiBoResponseModel.h"
#import "MYWeiBoShareMediaModel.h"
#import "MYMusixiseLoginManager.h"

@interface MYWeiboManager ()

@property(nonatomic, strong) NSString *wbtoken;
@property(nonatomic, strong) NSString *wbCurrentUserID;
@property(nonatomic, strong) NSString *wbRefreshToken;

@end

@implementation MYWeiboManager

- (void)setup {
    [WeiboSDK registerApp:kWeiboAppKey];
    
}

- (void)shareWithShareModel:(MYBaseWeiBoShareModel *)shareModel {
    WBMessageObject *message = [WBMessageObject message];
    message.text = shareModel.text;
    if ([shareModel isKindOfClass:[MYWeiBoShareImageModel class]]) {
        if (shareModel.imageData) {
            WBImageObject *image = [WBImageObject object];
            image.imageData = shareModel.imageData;
            message.imageObject = image;
        }
        
    } else if ([shareModel isKindOfClass:[MYWeiBoShareMediaModel class]]){
        MYWeiBoShareMediaModel *mediaModel = (MYWeiBoShareMediaModel *)shareModel;
        WBWebpageObject *webpage = [WBWebpageObject object];
        webpage.objectID = mediaModel.objdctID;
        webpage.title = mediaModel.title;
        webpage.description = mediaModel.detailTitle;
        webpage.thumbnailData = mediaModel.imageData;
        webpage.webpageUrl = mediaModel.webPageUrl;
        message.mediaObject = webpage;
    }
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kWeiboAddressRedictURI;
    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
    request.shouldShowWebViewForAuthIfCannotSSO = YES;
    request.scope = @"all";
    WBSendMessageToWeiboRequest *weiboRequest = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:request access_token:self.wbtoken];
    weiboRequest.userInfo = @{@"ShareMessageFrom":@"Musixise"};
    [WeiboSDK sendRequest:weiboRequest];
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class]) {
        NSString *title = NSLocalizedString(@"发送结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode, NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil),response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        WBSendMessageToWeiboResponse* sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse*)response;
        NSString* accessToken = [sendMessageToWeiboResponse.authResponse accessToken];
        if (accessToken)
        {
            self.wbtoken = accessToken;
        }
        NSString* userID = [sendMessageToWeiboResponse.authResponse userID];
        if (userID) {
            self.wbCurrentUserID = userID;
        }
        [alert show];
    } else if ([response isKindOfClass:WBAuthorizeResponse.class]) {
        // 登录
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

        NSString *title = NSLocalizedString(@"认证结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\nresponse.userId: %@\nresponse.accessToken: %@\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode,[(WBAuthorizeResponse *)response userID], [(WBAuthorizeResponse *)response accessToken],  NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil), response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        
        self.wbtoken = [(WBAuthorizeResponse *)response accessToken];
        self.wbCurrentUserID = [(WBAuthorizeResponse *)response userID];
        self.wbRefreshToken = [(WBAuthorizeResponse *)response refreshToken];
        [alert show];
    } else if ([response isKindOfClass:WBPaymentResponse.class]) {
        NSString *title = NSLocalizedString(@"支付结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\nresponse.payStatusCode: %@\nresponse.payStatusMessage: %@\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode,[(WBPaymentResponse *)response payStatusCode], [(WBPaymentResponse *)response payStatusMessage], NSLocalizedString(@"响应UserInfo数据", nil),response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil), response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
    } else if([response isKindOfClass:WBSDKAppRecommendResponse.class]) {
        NSString *title = NSLocalizedString(@"邀请结果", nil);
        NSString *message = [NSString stringWithFormat:@"accesstoken:\n%@\nresponse.StatusCode: %d\n响应UserInfo数据:%@\n原请求UserInfo数据:%@",[(WBSDKAppRecommendResponse *)response accessToken],(int)response.statusCode,response.userInfo,response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }else if([response isKindOfClass:WBShareMessageToContactResponse.class]) {
        NSString *title = NSLocalizedString(@"发送结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode, NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil),response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        WBShareMessageToContactResponse* shareMessageToContactResponse = (WBShareMessageToContactResponse*)response;
        NSString* accessToken = [shareMessageToContactResponse.authResponse accessToken];
        if (accessToken)
        {
            self.wbtoken = accessToken;
        }
        NSString* userID = [shareMessageToContactResponse.authResponse userID];
        if (userID) {
            self.wbCurrentUserID = userID;
        }
        [alert show];
    }

}

@end
