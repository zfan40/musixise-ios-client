//
//  MYAlertCheckboxView.m
//  Pods
//
//  Created by wmy on 16/2/2.
//
//

#import "MYAlertCheckboxView.h"
#import "MYCheckboxView.h"
#import "UILabel+MYStyle.h"
#import <MYUtils/MYSafeUtil.h>

#define kMYAlertCheckboxViewWidght 280
#define kMYAlertCheckboxViewHeight 167

typedef void(^clickBlock)(int index,BOOL isSelect);

@interface MYAlertCheckboxView () <MYCheckboxViewDelegate>


@property (nonatomic,assign) BOOL isSelect;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *messageLabel;
@property (nonatomic,strong) MYCheckboxView *checkboxView;
@property (nonatomic,strong) UILabel *cancelLabel;
@property (nonatomic,strong) UILabel *otherLabel;
@property (nonatomic,copy) clickBlock block;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UIView *vLineView;
@end

@implementation MYAlertCheckboxView

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
    self.userInteractionEnabled = YES;
    [self addSubview:self.titleLabel];
    [self addSubview:self.messageLabel];
    [self addSubview:self.checkboxView];
    [self addSubview:self.lineView];
    [self addSubview:self.vLineView];
    [self addSubview:self.cancelLabel];
    [self addSubview:self.otherLabel];
    self.cornerRadius = 10;
    self.backgroundColor = theMYWidget.itemViewColor;
    
}

+ (MYAlertCheckboxView *)alertCheckboxViewWith:(NSString *)title
                                   messageText:(NSString *)message
                                     checkText:(NSString *)checkText
                                    cancelText:(NSString *)cancelText
                                     otherText:(NSString *)otherText
                              clickButtonBlock:(void(^)(int buttonIndex,BOOL isSelect))buttonBlock {
    
    MYAlertCheckboxView *alertView = [[MYAlertCheckboxView alloc] init];
    alertView.width = kMYAlertCheckboxViewWidght;
    alertView.height = kMYAlertCheckboxViewHeight;
    if (!isEmptyString(title)) {
        alertView.titleLabel.text = title;
    }
    if (!isEmptyString(message)) {
        alertView.messageLabel.text = message;
    }
    if (!isEmptyString(checkText)) {
        [alertView.checkboxView setMessage:checkText];
    }
    if (!isEmptyString(cancelText)) {
        alertView.cancelLabel.text = cancelText;
    }
    if (!isEmptyString(otherText)) {
        alertView.otherLabel.text = otherText;
    }
    alertView.block = buttonBlock;
    [alertView setNeedsLayout];
    return alertView;
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.titleLabel setSizeWithSize:CGSizeZero];
    self.titleLabel.top = theMYWidget.m5;
    self.titleLabel.centerX = self.width * 0.5;
    
    [self.messageLabel setSizeWithSize:CGSizeZero];
    self.messageLabel.top = theMYWidget.m3 + self.titleLabel.bottom;
    self.messageLabel.centerX = self.width * 0.5;
    
    self.checkboxView.top = self.messageLabel.bottom + theMYWidget.m3;
    self.checkboxView.centerX = self.width * 0.5;
    
    self.lineView.width = self.width;
    self.lineView.left = 0;
    self.lineView.bottom = self.height - 45;
    
    self.cancelLabel.width = self.width * 0.5;
    self.cancelLabel.height = 44;
    self.cancelLabel.top = self.lineView.bottom;
    self.cancelLabel.left = 0;
    
    self.vLineView.height = self.cancelLabel.height;
    self.vLineView.left = self.cancelLabel.right;
    self.vLineView.top = self.cancelLabel.top;
    
    self.otherLabel.width = self.cancelLabel.width;
    self.otherLabel.height = 44;
    self.otherLabel.left = self.vLineView.right;
    self.otherLabel.top = self.cancelLabel.top;
    
}

#pragma mark - --------------------功能函数------------------
#pragma mark - --------------------手势事件------------------

- (void)onClickCancel {
    if (self.block) {
        self.block(-1,self.isSelect);
    }
    if ([self.delegate respondsToSelector:@selector(alertCheckboxViewDidClickCancel)]) {
        [self.delegate alertCheckboxViewDidClickCancel];
    }
}

- (void)onClickOther {
    if (self.block) {
        self.block(1,self.isSelect);
    }
    if ([self.delegate respondsToSelector:@selector(alertCheckboxViewDidClickOther)]) {
        [self.delegate alertCheckboxViewDidClickOther];
    }
    
}

#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------

#pragma mark MYCheckboxViewDelegate

- (void)checkboxViewDidClick:(BOOL)isSelected {
    self.isSelect = isSelected;
}

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
        _titleLabel.numberOfLines = 1;
    }
    return _titleLabel;
}

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [UILabel labelWithStyle:MYWidgetStyle_MYWidget_tt_c2_f4_a80 withTextAligment:NSTextAlignmentCenter];
        _messageLabel.text = @"内容";
        _messageLabel.numberOfLines = 1;
    }
    return _messageLabel;
}

- (MYCheckboxView *)checkboxView {
    if (!_checkboxView) {
        _checkboxView = [MYCheckboxView checkboxViewWith:@"checkbox"];
        _checkboxView.delegate = self;
    }
    return _checkboxView;
}

- (UILabel *)cancelLabel {
    if (!_cancelLabel) {
        _cancelLabel = [UILabel labelWithStyle:MYWidgetStyle_MYWidget_tt_c2_f4_a80 withTextAligment:NSTextAlignmentCenter];
        _cancelLabel.text = @"取消";
        _cancelLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *cancelTap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                  action:@selector(onClickCancel)];
        [_cancelLabel addGestureRecognizer:cancelTap];
    }
    return _cancelLabel;
}

- (UILabel *)otherLabel {
    if (!_otherLabel) {
        _otherLabel = [UILabel labelWithStyle:MYWidgetStyle_MYWidget_tt_c2_f4_a80 withTextAligment:NSTextAlignmentCenter];
        _otherLabel.text = @"确认";
        _otherLabel.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *otherTap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                  action:@selector(onClickOther)];
        [_otherLabel addGestureRecognizer:otherTap];
    }
    return _otherLabel;
}

@end
