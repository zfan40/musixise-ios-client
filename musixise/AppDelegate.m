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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    MYMainViewController *main = [[MYMainViewController alloc] init];
    MYNavigationController *navi = [[MYNavigationController alloc] initWithRootViewController:main];
    self.window.rootViewController = navi;
//    [NSThread sleepForTimeInterval:3];
    // 初始化route
    // router初始化
    NSMutableArray *array = [NSMutableArray array];
    MYRouteManagerModel *routeManagerModel = [[MYRouteManagerModel alloc] init];
    routeManagerModel.urlManagerName = @"MYMainRouteManager";
    routeManagerModel.filePath = [[NSBundle mainBundle] pathForResource:@"scheme_url" ofType:@"json"];
    [array addObject:routeManagerModel];
    [router setup:navi withManagerModels:array];
    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [[MYLoginManager sharedInstance] handleWithURL:url];
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
