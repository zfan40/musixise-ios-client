//
//  TTAppDelegate.h
//  treeBank
//
//  Created by kebi on 16/3/21.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTAppDelegate.h"
#import "TTMainViewController.h"
#import "TTNavigator.h"
#import "TTRouter.h"
#import "TTRouter+Load.h"
#import "TTWalkThroughViewController.h"
void setupRouter() {
    dispatch_async(dispatch_get_main_queue(), ^{
        [TTRouter loadAllScheme];
    });
}

@interface TTAppDelegate ()

@end

@implementation TTAppDelegate

-(UIWindow*)otherWindow{
    if(!_otherWindow){
        _otherWindow =[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _otherWindow.rootViewController =[UIViewController new];
        _otherWindow.windowLevel = UIWindowLevelStatusBar - 1.0f;
    }
    return _otherWindow;
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    BOOL firstRun = [[NSUserDefaults standardUserDefaults]objectForKey:@"appFirstRun"];
    if(!firstRun){
        [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:@"appFirstRun"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        TTWalkThroughViewController *walkThroughView =[TTWalkThroughViewController new];
        walkThroughView.frame = [UIScreen mainScreen].bounds;
        [self.otherWindow makeKeyAndVisible];
        [self.otherWindow addSubview:walkThroughView];
        
    }
    
    
    TTMainViewController *mainViewController = [TTMainViewController new];
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:mainViewController];
    [TTNavigator sharedInstance].navigationController = navigationController;
    navigationController.navigationBarHidden = YES;
    navigationController.delegate = [TTNavigator sharedInstance];
    
    
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    setupRouter();
    return YES;
}


-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
