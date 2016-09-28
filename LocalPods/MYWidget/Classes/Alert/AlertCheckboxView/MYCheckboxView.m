//
//  MYCheckboxView.m
//  Pods
//
//  Created by wmy on 16/2/2.
//
//  带checkbox的view

#import "MYCheckboxView.h"
#import "UILabel+MYStyle.h"
#define kMYCheckboxViewWidth 280
#define kMYCheckboxViewHeight 20

@interface MYCheckboxView ()

@property (nonatomic,strong) UIButton *checkboxButton;
@property (nonatomic,strong) UILabel *messageLabel;

@end

@implementation MYCheckboxView

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
    self.isSelected = NO;
    UITapGestureRecognizer *checkTap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                              action:@selector(onClickCheckbox)];
    [self addGestureRecognizer:checkTap];
    [self addSubview:self.checkboxButton];
    [self addSubview:self.messageLabel];
}

+ (MYCheckboxView *)checkboxViewWith:(NSString *)message {
    MYCheckboxView *checkView = [[MYCheckboxView alloc] init];
    checkView.width = kMYCheckboxViewWidth;
    checkView.height = kMYCheckboxViewHeight;
    checkView.messageLabel.text = message;
    [checkView.messageLabel setSizeWithSize:CGSizeZero];
    checkView.width = checkView.messageLabel.width + checkView.checkboxButton.width + theMYWidget.m2;
    return checkView;
}

+ (MYCheckboxView *)checkboxView {
    MYCheckboxView *checkView = [[MYCheckboxView alloc] init];
    checkView.width = kMYCheckboxViewWidth;
    checkView.height = kMYCheckboxViewHeight;
    return checkView;
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
    self.checkboxButton.left = 0;
    self.checkboxButton.centerY = self.height * 0.5;
    
    [self.messageLabel setSizeWithSize:CGSizeZero];
    self.messageLabel.centerY = self.checkboxButton.centerY;
    self.messageLabel.left = self.checkboxButton.right;
}

#pragma mark - --------------------功能函数------------------

- (void)setMessage:(NSString *)message {
    self.messageLabel.text = message;
    [self setNeedsLayout];
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------

- (void)onClickCheckbox {
    self.isSelected = !self.isSelected;
    self.checkboxButton.selected = self.isSelected;
    if ([self.delegate respondsToSelector:@selector(checkboxViewDidClick:)]) {
        [self.delegate checkboxViewDidClick:self.isSelected];
    }
}

#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [UILabel labelWithStyle:MYWidgetStyle_MYWidget_tt_c2_f3_a80 withTextAligment:NSTextAlignmentCenter];
    }
    return _messageLabel;
}

- (UIButton *)checkboxButton {
    if (!_checkboxButton) {
        _checkboxButton = [[UIButton alloc] init];
        _checkboxButton.width = 20;
        _checkboxButton.height = 20;
        [_checkboxButton setBackgroundImage:[UIImage imageNamed:@"order_protocol_check_icon"] forState:UIControlStateSelected];
        [_checkboxButton setBackgroundImage:[UIImage imageNamed:@"order_protocol_not_icon"] forState:UIControlStateNormal];
        [_checkboxButton addTarget:self action:@selector(onClickCheckbox) forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkboxButton;
}

@end
