//
//  CZTabBarController.h
//  xiaplay
//
//  Created by apple on 15-3-4.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYTabBar.h"

#define TheTabBarViewController [MYTabBarViewController sharedInstance]

@class MYNavigationController;

@interface MYTabBarViewController : UITabBarController

+ (instancetype)sharedInstance;

- (NSArray<MYTabBarModel> *)setUpAllChildViewController;

- (MYNavigationController *)currentNavigationVC;

- (void)showtip:(NSString *)tip;

@end
