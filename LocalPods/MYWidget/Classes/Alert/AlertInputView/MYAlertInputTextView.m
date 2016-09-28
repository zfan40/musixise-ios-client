//
//  MYAlertInputTextView.m
//  Pods
//
//  Created by wmy on 16/1/29.
//
//

#import "MYAlertInputTextView.h"
#import <MYUtils/UIView+MYAdditons.h>
#import <MYUtils/MYSafeUtil.h>
#import <MYIconFont/MYButtonFactory.h>
#import "UILabel+MYStyle.h"
#import "UITextView+MYStyle.h"

#define kMYAlertInputTextViewheight 30
#define kMYAlertInputTextViewWidth 250

@interface MYAlertInputTextView ()

@property (nonatomic,strong) UILabel *placeableLabel;
@property (nonatomic,strong) UIButton *deleteButton;
@property (nonatomic,strong) UITextView *textView;

@end


@implementation MYAlertInputTextView


#pragma mark - --------------------退出清空------------------

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

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
    self.backgroundColor = theMYWidget.seperatorColor;
    self.userInteractionEnabled = YES;
    [self addSubview:self.placeableLabel];
    [self addSubview:self.textView];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onTextChanged)
                                                 name:UITextViewTextDidChangeNotification
                                               object:nil];
    
}


+ (MYAlertInputTextView *)alertInputTextViewWithplaceholderTitle:(NSString *)title {
    MYAlertInputTextView *alertInputTextView = [[MYAlertInputTextView alloc] init];
    alertInputTextView.placeableLabel.text = title;
    alertInputTextView.width = kMYAlertInputTextViewWidth;
    alertInputTextView.height = kMYAlertInputTextViewheight;
    return alertInputTextView;
}

+ (MYAlertInputTextView *)alertInputTextView {
    MYAlertInputTextView *alertInputTextView = [[MYAlertInputTextView alloc] init];
    alertInputTextView.width = kMYAlertInputTextViewWidth;
    alertInputTextView.height = kMYAlertInputTextViewheight;
    return alertInputTextView;
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
    self.cornerRadius = self.height * 0.5;
    [self.placeableLabel sizeToFit];
    self.placeableLabel.left = theMYWidget.m3;
    self.placeableLabel.centerY = self.height * 0.5;
    
    self.textView.width = self.width - theMYWidget.m3 * 2;
    self.textView.height = self.height;
    self.textView.centerX = self.width * 0.5;
    self.textView.centerY = self.height * 0.5;
    
    self.deleteButton.right = self.textView.width;
    self.deleteButton.centerY = self.height * 0.5;
    
}

#pragma mark - --------------------功能函数------------------

- (void)setPlaceholderTitle:(NSString *)placeholder {
    self.placeableLabel.text = placeholder;
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------



- (void)onClickDelete {
#ifdef DEBUG
    NSLog(@"onClickDelete");
#endif
    self.textView.text = @"";
}

#pragma mark - --------------------代理方法------------------

- (void)onTextChanged {
    self.placeableLabel.hidden = !isEmptyString(self.textView.text);
    self.deleteButton.hidden = isEmptyString(self.textView.text);
    self.text = self.textView.text;
    if ([self.delegate respondsToSelector:@selector(alertInputTextViewTextDidChange:)]) {
        [self.delegate alertInputTextViewTextDidChange:self.textView.text];
    }
}

#pragma mark - --------------------属性相关------------------

- (UITextView *)textView {
    if (!_textView) {
        _textView  = [UITextView textViewWithWidgetStyle:MYWidgetStyle_MYWidget_tt_c2_f2_a80];
        _textView.backgroundColor = [UIColor clearColor];
        [_textView addSubview:self.deleteButton];
    }
    return _textView;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [MYButtonFactory buttonWithImageName:@"iconFont-quxiao"
                                                        size:16
                                                       color:theMYWidget.c1_a50];
        _deleteButton.width = 20;
        _deleteButton.height = 20;
        _deleteButton.hidden = YES;
        [_deleteButton addTarget:self action:@selector(onClickDelete) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

- (UILabel *)placeableLabel {
    if (!_placeableLabel) {
        _placeableLabel = [UILabel labelWithStyle:MYWidgetStyle_MYWidget_tt_c2_f2_a20 withTextAligment:NSTextAlignmentLeft];
    }
    return _placeableLabel;
}

@end
