//
//  MYMusixiseLoginManager.m
//  Pods
//
//  Created by wmy on 16/9/28.
//
//  通过第三方拿到key后，需要调用此来拿应用的accessToken

#import "MYMusixiseLoginManager.h"
#import <MYUtils/MYDubugLog.h>
#import "MYSystemLoginManager.h"
#import <MYNetwork/MYBaseNetWorkUtil.h>
#import "MYWeiBoResponseModel.h"

@implementation MYMusixiseLoginManager

- (void)musixiseLoginWithType:(MYLoginType)loginType withModel:(MYWeiBoResponseModel *)model withCallback:(RequestCallback)callback {
    NSString *method = @"user/authByAccessToken/";
    NSString *type;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    switch (loginType) {
        case MYLoginType_QQ: {
            type = @"qq";
        }
            break;
        case MYLoginType_Weibo: {
            type = @"weibo";
            [dict setObject:model.accessToken forKey:@"accessToken"];
        }
            break;
        case MYLoginType_Normal: {
            type = @"";
        }
            break;
        case MYLoginType_Taobao: {
            type = @"";
        }
            break;
        case MYLoginType_Weixin: {
            type = @"weixin";
        }
            break;
    }
    
    
    NSString *requestMethod = [NSString stringWithFormat:@"%@%@",method,type];
    [[MYBaseNetWorkUtil sharedInstance] posthttpWithDictionary:dict
                                                    withMethod:requestMethod
                                                  withComplete:^(NSDictionary * _Nonnull result, BOOL success, NSError * _Nullable error) {
                                                      //TODO: wmy 返回参数待定
                                                      NSInteger errcode = [[dict objectForKey:@"errcode"] integerValue];
                                                      if (!errcode) {
                                                          NSDictionary *resultDict = [result objectForKey:@"data"];
                                                          NSString *idToken = [resultDict objectForKey:@"id_token"];
                                                          NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                                          [defaults setObject:idToken forKey:@"idToken"];
                                                          [defaults synchronize];
                                                          // 通过idToken拿信息
                                                          [[MYSystemLoginManager sharedInstance] getUserInfo];
                                                          //TODO: wmy 通过idToken来拿信息？
                                                          // 1. 先访问是否已经被绑定
                                                          // 2. 若没有被绑定就需要询问
                                                          // 3. 若已经被绑定了，那么就通过idToken来拿信息
                                                      }
                                                      if (callback) {
                                                          callback(success,error);
                                                      }
    }];
    
}

@end
