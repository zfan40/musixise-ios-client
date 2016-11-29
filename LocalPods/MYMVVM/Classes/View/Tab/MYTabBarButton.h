//
//  CZTabBarButton.h
//  xiaplay
//
//  Created by apple on 15-3-5.
//  Copyright (c) 2015年 apple. All rights reserved.
//  底部tabBar的按钮item

#import <UIKit/UIKit.h>
#import "MYTabBarModel.h"

@protocol MYTabBarButtonDelegate <NSObject>

- (void)tabBarButtonDidClickBadgeView;

@end

@interface MYTabBarButton : UIView

@property(nonatomic, assign) BOOL selected;
@property(nonatomic, weak) id<MYTabBarButtonDelegate> delegate;
/**
 初始化方法

 @param title title
 @param image image
 */
+ (instancetype)tabBarButtonWithModel:(id<MYTabBarModel>)model;

- (void)setNewsValue:(NSInteger)value;

@end


