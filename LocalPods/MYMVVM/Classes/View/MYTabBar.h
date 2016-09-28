//
//  CZTabBar.h
//  xiaplay
//
//  Created by apple on 15-3-4.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MYTabBar;

@protocol CZTabBarDelegate <NSObject>

@optional
- (void)tabBar:(MYTabBar *)tabBar didClickButton:(NSInteger)index;

@end


@interface MYTabBar : UIView

//@property (nonatomic, assign) NSUInteger tabBarButtonCount;

// items:保存每一个按钮对应tabBarItem模型
@property (nonatomic, strong) NSArray *items;

@property (nonatomic, weak) id<CZTabBarDelegate> delegate;

@end
