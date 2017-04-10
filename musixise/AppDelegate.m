//
//  AppDelegate.m
//  musixise
//
//  Created by wmy on 16/9/23.
//  Copyright © 2016年 wmy. All rights reserved.
//

#import "AppDelegate.h"
#import <MYMVVM/MYNavigationController.h>
#import "MYMainViewController.h"
#import <MYMVVM/MYRouteManagerModel.h>
#import <MYUserSystem/MYLoginManager.h>
#import "MYAppDelegateUtils.h"
#import "MYRootTabBarViewController.h"
#import "MYLoginViewController.h"
#import "MYLoginNavigationViewController.h"
#import <MYUserSystem/MYUserUtils.h>
#import <MYThirdKit/MYThirdManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 若第一次升级到此app，则显示欢迎页
    //TODO: wmy 将此收口入web的初始化工具类中
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    NSString *oldAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    NSLog(@"old agent :%@", oldAgent);
    
    //add my info to the new agent
    NSString *newAgent = [NSString stringWithFormat:@"Musixise %@",oldAgent];
//    NSString *newAgent = oldAgent;
    NSLog(@"new agent :%@", newAgent);
    
    //regist the new agent
    NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:newAgent, @"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
    
    
    
    
    MYBaseViewController *vc = [[MYAppDelegateUtils sharedInstance] showViewController];

    MYRootTabBarViewController *tabBarVc = [[MYRootTabBarViewController alloc] init];
    //TODO: wmy 暂时添加登录的入口
    MYLoginViewController *login = [[MYLoginViewController alloc] init];
    MYLoginNavigationViewController *loginNavi = [[MYLoginNavigationViewController alloc] initWithRootViewController:login];
    //TODO: wmy 写死为tab
    self.window.rootViewController = loginNavi;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onUserChange) name:@"MYUserDidChanged" object:nil];
    [NSThread sleepForTimeInterval:3];
    // 初始化route
    // router初始化
    //TODO: wmy 这部分需要将其放到某个routeUtil中
    NSMutableArray *array = [NSMutableArray array];
    MYRouteManagerModel *routeManagerModel = [[MYRouteManagerModel alloc] init];
    routeManagerModel.urlManagerName = @"MYMainRouteManager";
    routeManagerModel.filePath = [[NSBundle mainBundle] pathForResource:@"scheme_url" ofType:@"json"];
    [array addObject:routeManagerModel];
    //TODO: wmy 待删，之后会将其收口到MYAppDelegateUtils中
    [router setup:loginNavi withManagerModels:array];
    // 皮肤安装
    [[MYWidget sharedInstance] setup];
    // 第三方安装
    [[MYThirdManager sharedInstance] setup];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)onUserChange {
    long long userId = [MYUserUtils sharedInstance].userId;
    if (userId) {
        MYRootTabBarViewController *tabBarVc = [[MYRootTabBarViewController alloc] init];
        self.window.rootViewController = tabBarVc;
    } else {
        MYLoginViewController *login = [[MYLoginViewController alloc] init];
        MYLoginNavigationViewController *loginNavi = [[MYLoginNavigationViewController alloc] initWithRootViewController:login];
        self.window.rootViewController = loginNavi;
    }
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    NSString *urlStr = url.absoluteString;
    if ([urlStr hasPrefix:@"musixise"]) {
        [router routeUrl:urlStr];
        return YES;
    } else {
        return [[MYThirdManager sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    }
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    // TODO: wmy 添加route的跳转(需要集成到MYThirdManager)
    
    return [[MYLoginManager sharedInstance] handleWithURL:[url absoluteString]];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
