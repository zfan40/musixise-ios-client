//
//  MYTextView.m
//  Pods
//
//  Created by wmy on 16/6/6.
//
//

#import "MYTextView.h"
#import "UITextView+MYStyle.h"
#import "UILabel+MYStyle.h"

@interface MYTextView ()

// 提示语
@property (nonatomic,strong) UILabel *placeholderLabel;
// 输入框
@property (nonatomic,strong) UITextView *textView;

@end

@implementation MYTextView

#pragma mark - --------------------退出清空------------------


#pragma mark - --------------------初始化--------------------

- (instancetype)init {
    if (self = [super init]) {
        [self initWithView];
    }
    return self;
}

- (void)initWithView {
    [self addSubview:self.textView];
    [self addSubview:self.placeholderLabel];
}

+ (instancetype)textViewWithplaceText:(NSString *)text {
    MYTextView *textView = [[MYTextView alloc] init];
    [textView setPlaceHolderText:text];
    return textView;
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
    self.placeholderLabel.left = 0;
    self.placeholderLabel.centerY = self.height * 0.5;
    
    self.textView.width = self.width;
    self.textView.height = self.height;
    self.textView.contentOffset = CGPointMake(0, 30);

}

#pragma mark - --------------------功能函数------------------

- (void)setPlaceHolderText:(NSString *)text {
    self.placeholderLabel.text = text;
    [self.placeholderLabel sizeToFit];
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------


- (UILabel *)placeholderLabel {
    if (!_placeholderLabel) {
        _placeholderLabel = [UILabel labelWithStyle:MYWidgetStyle_MYWidget_tt_c2_f3_a50
                                   withTextAligment:NSTextAlignmentLeft];
    }
    return _placeholderLabel;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.textViewStyle = MYWidgetStyle_MYWidget_tt_c2_f2_a80;
        _textView.backgroundColor = [UIColor clearColor];
    }
    return _textView;
}

@end
