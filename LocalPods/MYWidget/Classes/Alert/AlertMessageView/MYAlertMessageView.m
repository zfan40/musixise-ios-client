//
//  MYAlertMessageView.m
//  Pods
//
//  Created by wmy on 16/1/30.
//
//

#import "MYAlertMessageView.h"
#import "UILabel+MYStyle.h"
#import <MYUtils/MYSafeUtil.h>

#define kMYAlertMessageViewWidth 280
#define kMYAlertMessageViewHeight 156

typedef void(^MYAlertMessageViewClickBlock)(void);

@interface MYAlertMessageView ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *descLabel;
@property (nonatomic,strong) UILabel *cancelButtonLabel;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,copy) MYAlertMessageViewClickBlock buttonBlock;


@end

@implementation MYAlertMessageView

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
    [self addSubview:self.descLabel];
    [self addSubview:self.cancelButtonLabel];
    [self addSubview:self.lineView];
}


+ (MYAlertMessageView *)alertMessageViewWithTitle:(NSString *)title
                                          message:(NSString *)message
                                           cancel:(NSString *)cancel
                                      cancelBlock:(void(^)(void))cancelBlock {
    
    MYAlertMessageView *alertMessageView = [[MYAlertMessageView alloc] init];
    alertMessageView.width = kMYAlertMessageViewWidth;
    alertMessageView.height = kMYAlertMessageViewHeight;
    if (!isEmptyString(title)) {
        alertMessageView.titleLabel.text = title;
    }
    if (!isEmptyString(message)) {
        alertMessageView.descLabel.text = message;
    }
    if (!isEmptyString(cancel)) {
        alertMessageView.cancelButtonLabel.text = cancel;
    }
    alertMessageView.buttonBlock = cancelBlock;
    return alertMessageView;
}
#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
    self.cornerRadius = 10;
    [self.titleLabel sizeToFit];
    self.titleLabel.width = self.width;
    self.titleLabel.centerX = self.width * 0.5;
    self.titleLabel.top = theMYWidget.m5;
    
    self.descLabel.width = self.width - 40 * 2;
    [self.descLabel setSizeWithSize:self.descLabel.size];
    self.descLabel.top = self.titleLabel.bottom + theMYWidget.m3;
    self.descLabel.centerX = self.width * 0.5;
    
    self.cancelButtonLabel.width = self.width;
    self.cancelButtonLabel.height = 44;
    self.cancelButtonLabel.bottom = self.height;
    
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
        self.buttonBlock();
    }
}

#pragma mark - --------------------按钮事件------------------

#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.height = theMYWidget.seperatorHeight;
        _lineView.backgroundColor = theMYWidget.seperatorColor;
    }
    return _lineView;
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

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithStyle:MYWidgetStyle_MYWidget_tt_c2_f4_a80 withTextAligment:NSTextAlignmentCenter];
        _titleLabel.text = @"标题";
    }
    return _titleLabel;
}

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [UILabel labelWithStyle:MYWidgetStyle_MYWidget_tt_c2_f4_a80 withTextAligment:NSTextAlignmentCenter];
        _descLabel.numberOfLines = 2;
        _descLabel.text = @"内容内容";
    }
    return _descLabel;
}

@end
