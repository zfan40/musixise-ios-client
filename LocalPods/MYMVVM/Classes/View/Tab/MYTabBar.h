//
//  CZTabBar.h
//  xiaplay
//
//  Created by apple on 15-3-4.
//  Copyright (c) 2015年 apple. All rights reserved.
//  底部TabBar

#import <UIKit/UIKit.h>
#import "MYTabBarModel.h"

@class MYTabBar;

@class MYBaseViewController;

@protocol MYTabBarDelegate <NSObject>

@optional

- (void)tabBar:(MYTabBar *)tabBar didClickButton:(NSInteger)index;

@end

@interface MYTabBar : UIView


@property (nonatomic, weak) id<MYTabBarDelegate> delegate;

+ (instancetype)tabBarWithBarModels:(NSArray<MYTabBarModel> *)barModels;

- (void)setSelectIndex:(NSInteger)index;


@end
