//
//  MYSystemLoginManager.m
//  Pods
//
//  Created by wmy on 2016/11/1.
//
//

#import "MYSystemLoginManager.h"
#import <MYUtils/MYSafeUtil.h>
#import "MYUser.h"
#import <MYNetwork/MYBaseNetWorkUtil.h>
#import "MYUserUtils.h"

@implementation MYSystemLoginManager

- (void)systemLoginWithName:(NSString *)title withPassword:(NSString *)password loginCallback:(LoginCallback)callback {
    if (isEmptyString(title) || isEmptyString(password)) {
        if (callback) {
            callback(NO,[NSError errorWithDomain:@"用户名或密码为空" code:1000 userInfo:@{}]);
        }
    } else {
        // 访问系统的登录
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:title forKey:@"username"];
        [dict setObject:password forKey:@"password"];
        [dict setObject:@(1) forKey:@"rememberMe"];
        NSString *method = @"authenticate";
        [[MYBaseNetWorkUtil sharedInstance] posthttpWithDictionary:dict
                                                        withMethod:method
                                                      withComplete:^(NSDictionary * _Nonnull result,
                                                                     BOOL success,
                                                                     NSError * _Nullable error) {
                                                          if (success) {
                                                              NSString *idToken = [result objectForKey:@"id_token"];
                                                              //TODO: wmy 根据idToken来获取用户信息
                                                              NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                                              [defaults setObject:idToken forKey:@"idToken"];
                                                              [defaults synchronize];
                                                              [self getUserInfo];
                                                              callback(YES,nil);
                                                          } else {
                                                              callback(NO,error);
                                                          }
                                                          
                                                      }];
    }
}

- (void)getUserInfo {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSString *method = @"user/getInfo";
    [[MYBaseNetWorkUtil sharedInstance] posthttpWithDictionary:dict withMethod:method withComplete:^(NSDictionary * _Nonnull result, BOOL success, NSError * _Nullable error) {
        if (success) {
            NSError *error;
            MYUserModel *userModel = [[MYUserModel alloc] initWithDictionary:[result objectForKey:@"data"]  error:&error];
            MYUser *user = [[MYUser alloc] initWithData:userModel];
            [[MYUserUtils sharedInstance] updateUser:user];
            [[NSNotificationCenter defaultCenter] postNotificationName:MYUserDidChanged object:nil];
        }
    }];
}


@end
