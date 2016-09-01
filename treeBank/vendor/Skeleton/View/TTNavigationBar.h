//
//  TTNavigationBar.h
//  TTUISkeleton
//
//  Created by guanshanliu on 11/20/15.
//  Copyright © 2015 TTPod. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, NavigationBarLeftButtonStyle) {
    NavigationBarLeftButtonStyleBack,   //返回
    NavigationBarLeftButtonStyleClose,  //关闭
    NavigationBarLeftButtonStyleSearch, //搜索
    NavigationBarLeftButtonStyleText,   //文本
    NavigationBarLeftButtonStyleNone
};

typedef NS_ENUM (NSInteger, NavigationBarTitleViewStyle) {
    NavigationBarTitleViewStyleText,    //文本
    NavigationBarTitleViewStyleSearch   //搜索条
};

typedef NS_OPTIONS(NSUInteger, NavigationBarRightButtonStyle) {
    NavigationBarRightButtonStyleNone       = 0,
    NavigationBarRightButtonStyleMessage    = 1 << 0, //消息
    NavigationBarRightButtonStyleMore       = 1 << 1, //更多
    NavigationBarRightButtonStylePlayer     = 1 << 2, //播放器
    NavigationBarRightButtonStyleText       = 1 << 3  //文本
};

@interface TTNavigationBar : UINavigationBar

/// 用于改变NavigationBar的alpha值，不影响title和buttons的alpha
@property (nonatomic, assign) CGFloat backgroundAlpha;
@property (nonatomic, readonly) UINavigationItem *navigationItem;
@property (nonatomic, readonly) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *backButton;

@end
