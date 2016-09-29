//
//  MYNavigationBar.m
//  Pods
//
//  Created by wmy on 16/9/28.
//
//

#import "MYNavigationBar.h"
#import <MYWidget/MYWidget.h>
#import <MYWidget/UILabel+MYStyle.h>
#import "MYNavigationView.h"

@interface MYNavigationBar ()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) MYNavigationView *leftView;
@property (strong, nonatomic) MYNavigationView *rightView;

@end

@implementation MYNavigationBar

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
    [self addSubview:self.titleLabel];
    [self addSubview:self.leftView];
    [self addSubview:self.rightView];
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.centerX = self.width * 0.5;
    self.titleLabel.centerY = self.height * 0.5;
    
    self.leftView.centerY = self.titleLabel.centerY;
    self.leftView.left = theMYWidget.m2;
    
    self.rightView.centerY = self.titleLabel.centerY;
    self.rightView.right = self.width - theMYWidget.m2;
}

#pragma mark - --------------------功能函数------------------

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
    [self.titleLabel sizeToFit];
    [self setNeedsLayout];
}

- (void)addSubViewToLeft:(UIView *)view {
    [self.leftView addSubview:view];
    [self setNeedsLayout];
}
- (void)addSubViewToRight:(UIView *)view {
    [self.rightView addSubview:view];
    [self setNeedsLayout];
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

newInstanceUILabel1(titleLabel, MYWidgetStyle_MYWidget_tt_c0_f3_a100)

- (MYNavigationView *)rightView {
    if (!_rightView) {
        _rightView = [MYNavigationView navigationView];
#if DEBUG
        _rightView.layer.borderColor = [UIColor blueColor].CGColor;
        _rightView.layer.borderWidth = 1;
#endif
    }
    return _rightView;
}

- (MYNavigationView *)leftView {
    if (!_leftView) {
        _leftView = [MYNavigationView navigationView];
#if DEBUG
        _leftView.layer.borderColor = [UIColor blueColor].CGColor;
        _leftView.layer.borderWidth = 1;
#endif
    }
    return _leftView;
}

@end
