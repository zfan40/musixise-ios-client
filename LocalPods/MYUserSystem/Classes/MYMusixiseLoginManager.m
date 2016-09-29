//
//  MYMusixiseLoginManager.m
//  Pods
//
//  Created by wmy on 16/9/28.
//
//  通过第三方拿到key后，需要调用此来拿应用的accessToken

#import "MYMusixiseLoginManager.h"
#import <MYUtils/MYDubugLog.h>
#import <MYNetwork/MYBaseNetWorkUtil.h>
#import "MYWeiBoResponseModel.h"

@implementation MYMusixiseLoginManager

- (void)musixiseLoginWithType:(MYLoginType)loginType withModel:(MYWeiBoResponseModel *)model withCallback:(RequestCallback)callback {
    NSString *method = @"musixisers/authByAccessToken/";
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
                                                      DebugLog(@"");
    }];
    
}

@end
