//
//  MYAppDelegateUtils.m
//  musixise
//
//  Created by wmy on 16/9/29.
//  Copyright © 2016年 wmy. All rights reserved.
//

#import "MYAppDelegateUtils.h"
#import <MYUtils/MYPhoneUtil.h>
#import <MYUserSystem/MYUserUtils.h>
#import "MYGlobalConfig.h"
#import <MYMVVM/MYBaseViewController.h>
#import <MYMVVM/MYRouteManagerModel.h>
#import "MYRootTabBarViewController.h"
#import "MYLaunchViewController.h"
#import "MYMainViewController.h"
#import "MYLoginViewController.h"

@implementation MYAppDelegateUtils

- (UIViewController *)showViewController {
    // 每次进入前，先去判断一下是否用户上次登录过，如果登录了，就进入tabBar的页面，如果没有登录，那么就进入Login的页面进行登录
    NSUserDefaults *share = [NSUserDefaults standardUserDefaults];
    NSString *version = [[MYPhoneUtil sharedInstance] version];
    NSString *plistVersion = [share objectForKey:kCurrentVersion];
    UIViewController *main;
    if ([plistVersion isEqualToString:version]) {
        // 为老版本
        // 1. 判断是否登录
        if ([MYUserUtils sharedInstance].userId) {
            main = [MYRootTabBarViewController sharedInstance];
        } else {
            main = [[MYLoginViewController alloc] init];
        }
    } else {
        // 为新版本
        MYLaunchViewController *launch = [[MYLaunchViewController alloc] init];
        main = launch;
        [share setObject:version forKey:kCurrentVersion];
        [share synchronize];
    }
    //TODO: wmy 这部分需要将其放到某个routeUtil中
    NSMutableArray *array = [NSMutableArray array];
    MYRouteManagerModel *routeManagerModel = [[MYRouteManagerModel alloc] init];
    routeManagerModel.urlManagerName = @"MYMainRouteManager";
    routeManagerModel.filePath = [[NSBundle mainBundle] pathForResource:@"scheme_url" ofType:@"json"];
    [array addObject:routeManagerModel];
    [router setupManagerModels:array];
    return main;
}

- (void)changeToLoginViewController {
    
}

@end
