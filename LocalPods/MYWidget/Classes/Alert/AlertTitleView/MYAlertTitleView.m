//
//  MYAlertTitleView.m
//  Pods
//
//  Created by wmy on 16/1/30.
//
//

#import "MYAlertTitleView.h"
#import "UILabel+MYStyle.h"
#import <MYUtils/MYSafeUtil.h>

#define kMYAlertTitleViewWidth 280
#define kMYAlertTitleViewHeight 106

typedef void(^clickBlock)(int buttonIndex);

@interface MYAlertTitleView ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *cancelButtonLabel;
@property (nonatomic,strong) UILabel *otherButtonLabel;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UIView *vLineView;
@property (nonatomic,copy) clickBlock block;

@end

@implementation MYAlertTitleView

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
    self.backgroundColor = theMYWidget.itemViewColor;
    self.userInteractionEnabled = YES;
    [self addSubview:self.titleLabel];
    [self addSubview:self.cancelButtonLabel];
    [self addSubview:self.otherButtonLabel];
    [self addSubview:self.lineView];
    [self addSubview:self.vLineView];
}


+ (MYAlertTitleView *)alertTitleViewWithTitle:(NSString *)title
                                       cancel:(NSString *)cancel
                              otherButtonText:(NSString *)other
                             clickButtonBlock:(void(^)(int buttonIndex))buttonBlock {
    MYAlertTitleView *alertTitleView = [[MYAlertTitleView alloc] init];
    alertTitleView.block = buttonBlock;
    if (!isEmptyString(title)) {
        alertTitleView.titleLabel.text = title;
    }
    if (!isEmptyString(cancel)) {
        alertTitleView.cancelButtonLabel.text = cancel;
    }
    if (!isEmptyString(other)) {
        alertTitleView.otherButtonLabel.text = other;
    }
    alertTitleView.block = buttonBlock;
    alertTitleView.width = kMYAlertTitleViewWidth;
    alertTitleView.height = kMYAlertTitleViewHeight;
    return alertTitleView;
    
}
#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
    self.cornerRadius = 10;
    [self.titleLabel sizeToFit];
    self.titleLabel.width = self.width;
    self.titleLabel.top = theMYWidget.m5;
    
    self.cancelButtonLabel.width = self.width * 0.5;
    self.cancelButtonLabel.height = 44;
    self.cancelButtonLabel.bottom = self.height;
    self.cancelButtonLabel.left = 0;
    
    self.vLineView.left = self.cancelButtonLabel.right;
    self.vLineView.height = self.cancelButtonLabel.height;
    
    self.otherButtonLabel.width = self.width * 0.5;
    self.otherButtonLabel.height = 44;
    self.otherButtonLabel.left = self.vLineView.right;
    self.otherButtonLabel.bottom = self.cancelButtonLabel.bottom;
    
    self.lineView.width = self.width;
    self.lineView.bottom = self.cancelButtonLabel.top;
    self.lineView.left = 0;
    
}

#pragma mark - --------------------功能函数------------------
#pragma mark - --------------------手势事件------------------

- (void)onClickCancel {
#ifdef DEBUG
    NSLog(@"onClickCancel");
#endif
    if (self.block) {
        self.block(-1);
    }
    if ([self.delegate respondsToSelector:@selector(alertTitleViewDidClickCancel)]) {
        [self.delegate alertTitleViewDidClickCancel];
    }
}

- (void)onClickOther {
#ifdef DEBUG
    NSLog(@"onClickOther");
#endif
    if (self.block) {
        self.block(1);
    }
    if ([self.delegate respondsToSelector:@selector(alertTitleViewDidClickOther)]) {
        [self.delegate alertTitleViewDidClickOther];
    }
}

#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

- (UIView *)vLineView {
    if (!_vLineView) {
        _vLineView = [[UIView alloc] init];
        _vLineView.width = theMYWidget.seperatorHeight;
        _vLineView.backgroundColor = theMYWidget.seperatorColor;
    }
    return _vLineView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.height = theMYWidget.seperatorHeight;
        _lineView.backgroundColor = theMYWidget.seperatorColor;
    }
    return _lineView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithStyle:MYWidgetStyle_MYWidget_tt_c2_f4_a80 withTextAligment:NSTextAlignmentCenter];
        _titleLabel.text = @"标题";
    }
    return _titleLabel;
}

- (UILabel *)cancelButtonLabel {
    if (!_cancelButtonLabel) {
        _cancelButtonLabel = [UILabel labelWithStyle:MYWidgetStyle_MYWidget_tt_c2_f4_a80 withTextAligment:NSTextAlignmentCenter];
        _cancelButtonLabel.text = @"取消";
        _cancelButtonLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *cancelTap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                  action:@selector(onClickCancel)];
        [_cancelButtonLabel addGestureRecognizer:cancelTap];
    }
    return _cancelButtonLabel;
}

- (UILabel *)otherButtonLabel {
    if (!_otherButtonLabel) {
        _otherButtonLabel = [UILabel labelWithStyle:MYWidgetStyle_MYWidget_tt_c2_f4_a80 withTextAligment:NSTextAlignmentCenter];
        _otherButtonLabel.text = @"确认";
        _otherButtonLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *otherTap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                  action:@selector(onClickOther)];
        [_otherButtonLabel addGestureRecognizer:otherTap];
    }
    return _otherButtonLabel;
}

@end
