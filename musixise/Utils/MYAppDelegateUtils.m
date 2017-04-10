//
//  MYAppDelegateUtils.m
//  musixise
//
//  Created by wmy on 16/9/29.
//  Copyright © 2016年 wmy. All rights reserved.
//

#import "MYAppDelegateUtils.h"
#import <MYUtils/MYPhoneUtil.h>
#import "MYGlobalConfig.h"
#import <MYMVVM/MYBaseViewController.h>
#import "MYRootTabBarViewController.h"
#import "MYLaunchViewController.h"
#import "MYMainViewController.h"

@implementation MYAppDelegateUtils

- (MYBaseViewController *)showViewController {
    //TODO: wmy 每次进入前，先去判断一下是否用户上次登录过，如果登录了，就进入tabBar的页面，如果没有登录，那么就进入Login的页面进行登录
    NSUserDefaults *share = [NSUserDefaults standardUserDefaults];
    NSString *version = [[MYPhoneUtil sharedInstance] version];
    NSString *plistVersion = [share objectForKey:kCurrentVersion];
    MYBaseViewController *vc = nil;
    if ([plistVersion isEqualToString:version]) {
        // 为老版本
        // 1. 判断是否登录
        
        MYNavigationController *main = [[MYNavigationController alloc] initWithRootViewController:[[MYMainViewController alloc] init]];
        vc = main;
    } else {
        // 为新版本
        MYLaunchViewController *launch = [[MYLaunchViewController alloc] init];
        vc = launch;
        [share setObject:version forKey:kCurrentVersion];
        [share synchronize];
    }
    
    //TODO: wmy 根据是登录还是tabBar进行设置navigation
//    [router setup:loginNavi withManagerModels:array];
    
    return vc;
}

- (void)changeToLoginViewController {
    
}

@end
