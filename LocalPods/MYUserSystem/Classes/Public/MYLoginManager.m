//
//  MYLoginManager.m
//  Pods
//
//  Created by wmy on 2016/11/1.
//
//

#import "MYLoginManager.h"
#import <MYUtils/MYSafeUtil.h>
#import "MYWeiBoLoginManager.h"
#import <MYThirdKit/MYThirdWeiboLoginManager.h>
#import <MYThirdKit/MYThirdManager.h>
#import "MYSystemLoginManager.h"

@implementation MYLoginManager

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (instancetype)init {
    self = [super init];
    if (self) {
        //TODO: wmy 注册第三方的各种key
        
    }
    return self;
}

#pragma mark - --------------------接口API------------------

- (void)loginWithType:(MYLoginType)type
             userName:(NSString *)name
             password:(NSString* )password
        loginCallback:(LoginCallback)callback {
    switch (type) {
        case MYLoginType_Normal:{
            [[MYSystemLoginManager sharedInstance] systemLoginWithName:name withPassword:password loginCallback:^(BOOL success) {
                if (callback) {
                    callback(success);
                    
                }
            }];
        }
            break;
        case MYLoginType_QQ:{
            
        }
            break;
        case MYLoginType_Taobao:{
            
        }
            break;
        case MYLoginType_Weibo:{
            [[MYWeiBoLoginManager sharedInstance] weiboLoginWithCallback:^(BOOL success) {
                if (callback) {
                    callback(success);
                }
            }];
        }
            break;
        case MYLoginType_Weixin:{
            
        }
            break;
    }
    
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return  [[MYThirdManager sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

- (BOOL)handleWithURL:(NSString *)url {
    return [[MYThirdWeiboLoginManager sharedInstance] handleWithURL:url];
}

#pragma mark - --------------------父类方法重写--------------
#pragma mark - --------------------功能函数------------------
#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

@end
