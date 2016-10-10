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
#import "MYMainViewController.h"
#import "MYLaunchViewController.h"

@implementation MYAppDelegateUtils

- (MYBaseViewController *)showViewController {
    NSUserDefaults *share = [NSUserDefaults standardUserDefaults];
    NSString *version = [[MYPhoneUtil sharedInstance] version];
    NSString *plistVersion = [share objectForKey:kCurrentVersion];
    MYBaseViewController *vc = nil;
    if ([plistVersion isEqualToString:version]) {
        MYMainViewController *main = [[MYMainViewController alloc] init];
        vc = main;
    } else {
        MYLaunchViewController *launch = [[MYLaunchViewController alloc] init];
        vc = launch;
        // TODO: wmy 添加到share
//        [share setObject:version forKey:kCurrentVersion];
//        [share synchronize];
    }
    return vc;
}

@end