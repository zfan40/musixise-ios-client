//
//  MYThirdWeiboShareManager.m
//  Pods
//
//  Created by wmy on 2016/11/1.
//
//

#import "MYThirdWeiboShareManager.h"
#import "MYThirdConstants.h"
#import "WeiboSDK.h"
#import "MYWeiBoShareImageModel.h"
#import "MYBaseWeiBoShareModel.h"
#import "MYWeiBoShareMediaModel.h"
#import "MYWeiBoResponseModel.h"
#import <MYNetwork/MYBaseNetWorkUtil.h>
#import <MYUtils/UIImage+MYImage.h>

@interface MYThirdWeiboShareManager () <WeiboSDKDelegate>

@property(nonatomic, strong) NSString *wbtoken;
@property(nonatomic, strong) NSString *wbCurrentUserID;
@property(nonatomic, strong) NSString *wbRefreshToken;

@end

@implementation MYThirdWeiboShareManager

- (WBMessageObject *)messageToShare
{
    WBMessageObject *message = [WBMessageObject message];
    
    
        WBWebpageObject *webpage = [WBWebpageObject object];
        webpage.objectID = @"identifier1";
        webpage.title = NSLocalizedString(@"分享网页标题", nil);
        webpage.description = [NSString stringWithFormat:NSLocalizedString(@"分享网页内容简介-%.0f", nil), [[NSDate date] timeIntervalSince1970]];
    UIImage *image = [UIImage createImageWithColor:[UIColor redColor] size:CGSizeMake(100,100)];
    
        webpage.thumbnailData = UIImageJPEGRepresentation(image,0.5);
//    webpage.thumbnailData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_2" ofType:@"jpg"]];
//        webpage.webpageUrl = @"http://m.xiami.com/throne/bought?playerBarMode=showPlayerBar";
    webpage.webpageUrl = @"http://www.xiami.com";
        message.mediaObject = webpage;
    
    
    return message;
}


- (void)shareWithShareModel:(id<MYShareModelProtocol>)shareModel {
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = kWeiboAddressRedictURI;
    authRequest.scope = @"all";
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare] authInfo:authRequest access_token:self.wbtoken];
    [WeiboSDK sendRequest:request];
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class]) {
        NSString *title = @"发送结果";
        NSString *message = [NSString stringWithFormat:@"%@: %d\n%@: %@\n%@: %@",@"响应状态", (int)response.statusCode, @"响应UserInfo数据", response.userInfo, @"原请求UserInfo数据",response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
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
    } else if ([response isKindOfClass:WBPaymentResponse.class]) {
        NSString *title = @"支付结果";
        NSString *message = [NSString stringWithFormat:@"%@: %d\nresponse.payStatusCode: %@\nresponse.payStatusMessage: %@\n%@: %@\n%@: %@", @"响应状态", (int)response.statusCode,[(WBPaymentResponse *)response payStatusCode], [(WBPaymentResponse *)response payStatusMessage], NSLocalizedString(@"响应UserInfo数据", nil),response.userInfo, @"原请求UserInfo数据", response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
    } else if([response isKindOfClass:WBSDKAppRecommendResponse.class]) {
        NSString *title = @"邀请结果";
        NSString *message = [NSString stringWithFormat:@"accesstoken:\n%@\nresponse.StatusCode: %d\n响应UserInfo数据:%@\n原请求UserInfo数据:%@",[(WBSDKAppRecommendResponse *)response accessToken],(int)response.statusCode,response.userInfo,response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
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

- (void)requestUserInfoWithAccesstoken:(NSString *)accessToken userId:(NSString *)userId {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:accessToken forKey:@"access_token"];
    [dict setObject:userId forKey:@"uid"];
    [[MYBaseNetWorkUtil sharedInstance] gethttpWithDictionary:dict url:@"https://api.weibo.com/2/users/show.json" withComplete:^(NSDictionary * _Nonnull result, BOOL success, NSError * _Nullable error) {
#if DEBUG
        NSLog(@"");
#endif
    }];
}


@end
