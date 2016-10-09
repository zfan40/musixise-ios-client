//
//  MYLoginItem.m
//  musixise
//
//  Created by wmy on 16/9/28.
//  Copyright © 2016年 wmy. All rights reserved.
//

#import "MYLoginItem.h"
#import <MYWidget/UILabel+MYStyle.h>
#import <MYIconFont/MYButtonFactory.h>

#define kButtonWidth 48

@interface MYLoginItem ()

@property (strong, nonatomic) UIButton *iconButton;
@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation MYLoginItem


#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    [self addSubview:self.iconButton];
    [self addSubview:self.titleLabel];
}


+ (instancetype)loginItemWithButtonName:(NSString *)name withTitle:(NSString *)title color:(UIColor *)color {
    MYLoginItem *item = [[MYLoginItem alloc] init];
    item.width = 64;
    item.height = 80;
    item.userInteractionEnabled = YES;
    [MYButtonFactory setButtonImage:item.iconButton WithimageName:name size:36 color:color];
    item.titleLabel.text = title;
    [item.titleLabel sizeToFit];
    [item setNeedsLayout];
    return item;
}
#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
    self.iconButton.centerX = self.width * 0.5;
    self.iconButton.top = 0;
    self.titleLabel.top = self.iconButton.bottom;
    self.titleLabel.centerX = self.width * 0.5;
}

#pragma mark - --------------------功能函数------------------
#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

newInstanceUILabel1(titleLabel, MYWidgetStyle_MYWidget_tt_c2_f2_a80)

- (UIButton *)iconButton {
    if (!_iconButton) {
        _iconButton =[UIButton buttonWithType:UIButtonTypeCustom];
        _iconButton.width = kButtonWidth;
        _iconButton.height = kButtonWidth;
        _iconButton.enabled = NO;
    }
    return _iconButton;
}


@end
