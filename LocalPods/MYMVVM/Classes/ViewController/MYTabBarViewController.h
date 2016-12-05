//
//  CZTabBarController.h
//  xiaplay
//
//  Created by apple on 15-3-4.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYTabBar.h"

@class MYNavigationController;

@interface MYTabBarViewController : UITabBarController

@property(nonatomic, assign) BOOL hideTabBar;

- (NSArray<MYTabBarModel> *)setUpAllChildViewController;

- (MYNavigationController *)currentNavigationVC;


@end
