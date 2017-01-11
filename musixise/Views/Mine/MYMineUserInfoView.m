//
//  MYMineUserInfoView.m
//  musixise
//
//  Created by wmy on 2016/12/21.
//  Copyright © 2016年 wmy. All rights reserved.
//

#import "MYMineUserInfoView.h"
#import <MYWidget/MYWidget.h>
#import "MYMineUserItemModel.h"
#import <MYWidget/UILabel+MYStyle.h>

#define kDetailLeft 58

@interface MYMineUserInfoView ()

@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *detailLabel;

@end

@implementation MYMineUserInfoView

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (instancetype)init {
    if (self = [super init]) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    [self addSubview:self.titleLabel];
    [self addSubview:self.detailLabel];
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.left = theMYWidget.m2;
    self.titleLabel.centerY = self.height * 0.5;
    
    self.detailLabel.left = kDetailLeft;
    self.detailLabel.centerY = self.height * 0.5;
}

- (void)viewModelDataChanged {
    [super viewModelDataChanged];
    if ([self.viewModel isKindOfClass:[MYMineUserItemModel class]]) {
        MYMineUserItemModel *user = (MYMineUserItemModel *)self.viewModel;
        [self setTitle:user.title];
        [self setDetailTitle:user.detailText];
    }
    [self setNeedsLayout];
}

#pragma mark - --------------------功能函数------------------

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
    [self.titleLabel sizeToFit];
}

- (void)setDetailTitle:(NSString *)detailTitle {
    if (isEmptyString(detailTitle)) {
        detailTitle = @"保密";
    }
    self.detailLabel.text = detailTitle;
    [self.detailLabel sizeToFit];
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

newInstanceUILabel1(titleLabel, MYWidgetStyle_MYWidget_tt_c2_f2_a80)
newInstanceUILabel1(detailLabel, MYWidgetStyle_MYWidget_tt_c2_f2_a80)

@end
