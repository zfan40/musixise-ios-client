//
//  CZTabBarButton.m
//  xiaplay
//
//  Created by apple on 15-3-5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "MYTabBarButton.h"
#import "MYBadgeView.h"
#import <MYIconFont/MYButtonFactory.h>
#import <MYUtils/UIView+MYAdditons.h>

#define CZImageRidio 0.7

@interface MYTabBarButton ()

@property (nonatomic, weak) MYBadgeView *badgeView;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIButton *iconBtn;
@property(nonatomic, strong) id<MYTabBarModel> model;


@end

@implementation MYTabBarButton


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
    [self addSubview:self.iconBtn];
    [self addSubview:self.badgeView];
    [self addSubview:self.titleLabel];
}

+ (instancetype)tabBarButtonWithModel:(id<MYTabBarModel>)model {
    //TODO: wmy
    MYTabBarButton *button = [[MYTabBarButton alloc] init];
    [button setModel:model];
    return button;
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

// 修改按钮内部子控件的frame
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat btnTop = (self.height - self.iconBtn.height - self.titleLabel.height) / 2;
    
    // 1.iconBtn
    self.iconBtn.centerX = self.width * 0.5;
    self.iconBtn.top = btnTop;
    
    // 2.title
    self.titleLabel.top = self.iconBtn.bottom;
    self.titleLabel.centerX = self.width * 0.5;
    
    // 3.badgeView
    self.badgeView.centerX = self.iconBtn.right;
    self.badgeView.centerY = self.iconBtn.top;
}

#pragma mark - --------------------功能函数------------------

- (void)setTitleText:(NSString *)text {
    self.titleLabel.text = text;
    [self.titleLabel sizeToFit];
}

- (void)setNewsValue:(NSInteger)value {
    [self.badgeView setValue:value];
    [self setNeedsLayout];
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------

- (void)onClickBadgeView {
    if ([self.delegate respondsToSelector:@selector(tabBarButtonDidClickBadgeView)]) {
        [self.delegate tabBarButtonDidClickBadgeView];
    }
}

#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

- (void)setModel:(id<MYTabBarModel>)model {
    _model = model;
    [self setTitleText:model.title];
    [MYButtonFactory setButtonImage:self.iconBtn
                      WithimageName:model.iconName
                               size:model.iconWidth
                              color:model.normalColor
                              state:UIControlStateNormal];
    [MYButtonFactory setButtonImage:self.iconBtn
                      WithimageName:model.iconName
                               size:model.iconWidth
                              color:model.selectColor
                              state:UIControlStateSelected];
    self.iconBtn.width = model.iconWidth;
    self.iconBtn.height = model.iconWidth;
    
    [self setNeedsLayout];
    
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    //TODO: wmy UI 当选中时，应该修改颜色
    self.iconBtn.selected = selected;
    self.titleLabel.textColor = selected ? self.model.selectColor : self.model.normalColor;
}

- (UIButton *)iconBtn {
    if (!_iconBtn) {
        _iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _iconBtn.userInteractionEnabled = NO;
#if DEBUG
        _iconBtn.layer.borderWidth = 1;
        _iconBtn.layer.borderColor = [UIColor redColor].CGColor;
#endif
    }
    return _iconBtn;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:11];
#if DEBUG
        _titleLabel.layer.borderWidth = 1;
        _titleLabel.layer.borderColor = [UIColor redColor].CGColor;
#endif
        //TODO: wmy UI
    }
    return _titleLabel;
}

- (MYBadgeView *)badgeView {
    if (!_badgeView) {
        _badgeView = [MYBadgeView badgeView];
        [_badgeView addTarget:self action:@selector(onClickBadgeView) forControlEvents:UIControlEventTouchUpInside];
#if DEBUG
        _badgeView.layer.borderWidth = 1;
        _badgeView.layer.borderColor = [UIColor redColor].CGColor;
#endif
    }
    return _badgeView;
}

@end
