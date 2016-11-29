//
//  CZBadgeView.h
//  xiaplay
//
//  Created by apple on 15-3-5.
//  Copyright (c) 2015年 apple. All rights reserved.
//  该view为tabBarItem的右上角的显示按钮

#import <UIKit/UIKit.h>

@interface MYBadgeView : UIButton

- (void)setValue:(NSInteger)value;

+ (instancetype)badgeView;

@end
