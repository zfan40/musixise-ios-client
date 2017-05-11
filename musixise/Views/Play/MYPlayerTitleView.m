//
//  MYPlayerTitleView.m
//  musixise
//
//  Created by wmy on 2017/4/21.
//  Copyright © 2017年 wmy. All rights reserved.
//

#import "MYPlayerTitleView.h"
#import <MYWidget/MYWidget.h>
#import <MYWidget/UILabel+MYStyle.h>

@interface MYPlayerTitleView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;

@end

@implementation MYPlayerTitleView



#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    [self addSubview:self.titleLabel];
    [self addSubview:self.subTitleLabel];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}
#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat top = (self.height -  self.titleLabel.height - self.subTitleLabel.height) / 2;
    self.titleLabel.centerX = self.width * 0.5;
    self.titleLabel.top = top;
    
    self.subTitleLabel.centerX = self.width * 0.5;
    self.subTitleLabel.top = self.titleLabel.bottom;
    
}

#pragma mark - --------------------功能函数------------------

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
    [self.titleLabel sizeToFit];
    [self setNeedsLayout];
}

- (void)setSubTitle:(NSString *)subTitle {
    self.subTitleLabel.text = subTitle;
    [self.subTitleLabel sizeToFit];
    [self setNeedsLayout];
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

newInstanceUILabel1(titleLabel, MYWidgetStyle_MYWidget_tt_c2_f3_a80)
newInstanceUILabel1(subTitleLabel, MYWidgetStyle_MYWidget_tt_c2_f3_a80)

@end
