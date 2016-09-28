//
//  MYAlertInputView.m
//  Pods
//
//  Created by wmy on 16/1/29.
//
//

#import "MYAlertInputView.h"
#import "UILabel+MYStyle.h"
#import "MYAlertInputTextView.h"
#import <MYUtils/MYSafeUtil.h>

#define kMYAlertInputViewHeight 179
#define kMYAlertInputViewWidth 280



@interface MYAlertInputView () <MYAlertInputTextViewDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic,strong) MYAlertInputTextView *alertInputTextView;
@property (nonatomic,strong) UILabel *numberLabel;
@property (nonatomic,assign) NSInteger length;
@property (nonatomic,weak) clickBlock buttonBlock;
@property (nonatomic,strong) UILabel *cancelButtonLabel;
@property (nonatomic,strong) UILabel *otherButtonLabel;

@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UIView *vLineView;

@end

@implementation MYAlertInputView

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
    self.backgroundColor = theMYWidget.itemViewColor;
    self.cornerRadius = 10;
    [self addSubview:self.titleLabel];
    [self addSubview:self.alertInputTextView];
    [self addSubview:self.numberLabel];
    [self addSubview:self.cancelButtonLabel];
    [self addSubview:self.otherButtonLabel];
    [self addSubview:self.lineView];
    [self addSubview:self.vLineView];
    
    
}

/**
 *  创建带输入框的对话框
 *
 *  @param title            标题
 *  @param placeable        提示语
 *  @param length           输入框可输入的最大长度，为0时不限制长度
 *  @param cancel           取消按钮的string，不设置时默认为“取消”
 *  @param otherButtonTitle 右侧按钮的string，不设置时，默认为“确定”
 *  @param block            点击时的回调(当buttonIndex=0时，为点击取消按钮，buttonIndex=1时，为点击确定按钮)
 *
 *  @return 带输入框的对话框
 */
+ (MYAlertInputView *)alertInputViewWithTitle:(NSString *)title
                                    placeable:(NSString *)placeable
                                       lenght:(NSUInteger)length
                                    cancelStr:(NSString *)cancel
                                  otherButton:(NSString *)otherButtonTitle
                                   clickBlock:(clickBlock)block {
    
    MYAlertInputView *alertInputView = [[MYAlertInputView alloc] init];
    alertInputView.length = length;
    alertInputView.width = kMYAlertInputViewWidth;
    alertInputView.height = kMYAlertInputViewHeight;
    if (!isEmptyString(title)) {
        alertInputView.titleLabel.text = title;
    }
    if (!isEmptyString(cancel)) {
        alertInputView.cancelButtonLabel.text = cancel;
    }
    if (!isEmptyString(otherButtonTitle)) {
        alertInputView.otherButtonLabel.text = otherButtonTitle;
    }
    if (length > 0) {
        alertInputView.numberLabel.text = [NSString stringWithFormat:@"0/%lu",(unsigned long)length];
        alertInputView.numberLabel.hidden = NO;
    } else if (length == 0) {
        alertInputView.numberLabel.hidden = YES;
    }
    [alertInputView.alertInputTextView setPlaceholderTitle:placeable];
    
    alertInputView.buttonBlock = block;
    [alertInputView setNeedsLayout];
    return alertInputView;
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.titleLabel sizeToFit];
    self.titleLabel.width = self.width;
    self.titleLabel.centerX = self.width * 0.5;
    self.titleLabel.top = theMYWidget.m5;
    self.alertInputTextView.centerX = self.centerX;
    self.alertInputTextView.top = self.titleLabel.bottom + theMYWidget.m5;
    
    [self.numberLabel sizeToFit];
    self.numberLabel.top = self.alertInputTextView.bottom + theMYWidget.m2;
    self.numberLabel.right = self.width - theMYWidget.m4;
    
    self.alertInputTextView.width = self.width - theMYWidget.m4 * 2;
    self.alertInputTextView.top = self.titleLabel.bottom + theMYWidget.m5;
    self.alertInputTextView.centerX = self.width * 0.5;
    
    self.cancelButtonLabel.width = self.width * 0.5;
    self.cancelButtonLabel.height = 44;
    self.cancelButtonLabel.bottom = self.height;
    self.cancelButtonLabel.left = 0;
    
    self.vLineView.height = self.cancelButtonLabel.height;
    self.vLineView.left = self.cancelButtonLabel.right;
    
    self.otherButtonLabel.width = self.width * 0.5;
    self.otherButtonLabel.height = 44;
    self.otherButtonLabel.bottom = self.cancelButtonLabel.bottom;
    self.otherButtonLabel.left = self.vLineView.right;
    
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
    if (self.buttonBlock) {
        self.buttonBlock(-1,self.alertInputTextView.text.length,self.alertInputTextView.text);
    }
    if ([self.delegate respondsToSelector:@selector(alertInputViewDidClickCancel)]) {
        [self.delegate alertInputViewDidClickCancel];
    }
}

- (void)onClickOther {
#ifdef DEBUG
    NSLog(@"onClickOther");
#endif
    if (self.buttonBlock) {
        self.buttonBlock(1,self.alertInputTextView.text.length,self.alertInputTextView.text);
    }
    if ([self.delegate respondsToSelector:@selector(alertInputViewDidClickOther)]) {
        [self.delegate alertInputViewDidClickOther];
    }
}

#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------

#pragma mark MYAlertInputTextViewDelegate


- (void)alertInputTextViewTextDidChange:(NSString *)text {
    self.numberLabel.text = [NSString stringWithFormat:@"%lu/%ld",(unsigned long)text.length,(long)self.length];
    [self setNeedsLayout];
}

#pragma mark - --------------------属性相关------------------

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.height = theMYWidget.seperatorHeight;
        _lineView.backgroundColor = theMYWidget.seperatorColor;
    }
    return _lineView;
}

- (UIView *)vLineView {
    if (!_vLineView) {
        _vLineView = [[UIView alloc] init];
        _vLineView.width = theMYWidget.seperatorHeight;
        _vLineView.backgroundColor = theMYWidget.seperatorColor;
    }
    return _vLineView;
}


- (UILabel *)otherButtonLabel {
    if (!_otherButtonLabel) {
        _otherButtonLabel = [UILabel labelWithStyle:MYWidgetStyle_MYWidget_tt_c2_f4_a80 withTextAligment:NSTextAlignmentCenter];
        _otherButtonLabel.text = @"确定";
        _otherButtonLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *otherTap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                  action:@selector(onClickOther)];
        [_otherButtonLabel addGestureRecognizer:otherTap];
    }
    return _otherButtonLabel;
}

- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [UILabel labelWithStyle:MYWidgetStyle_MYWidget_tt_c2_f2_a50 withTextAligment:NSTextAlignmentLeft];
    }
    return _numberLabel;
}

- (MYAlertInputTextView *)alertInputTextView {
    if (!_alertInputTextView) {
        _alertInputTextView = [MYAlertInputTextView alertInputTextView];
        _alertInputTextView.delegate = self;
    }
    return _alertInputTextView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithStyle:MYWidgetStyle_MYWidget_tt_c2_f4_a80
                             withTextAligment:NSTextAlignmentCenter];
        
    }
    return _titleLabel;
}

- (UILabel *)cancelButtonLabel {
    if (!_cancelButtonLabel ) {
        _cancelButtonLabel = [UILabel labelWithStyle:MYWidgetStyle_MYWidget_tt_c2_f4_a80 withTextAligment:NSTextAlignmentCenter];
        _cancelButtonLabel.text = @"取消";
        _cancelButtonLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *cancelTap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                  action:@selector(onClickCancel)];
        [_cancelButtonLabel addGestureRecognizer:cancelTap];
    }
    return _cancelButtonLabel;
}

@end
