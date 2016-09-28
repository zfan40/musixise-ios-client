//
//  MYTipsView.m
//  Pods
//
//  Created by wmy on 16/2/2.
//
//

#import "MYTipsView.h"
#import "UILabel+MYStyle.h"
#define kMYTipsHelperWidth 240
#define kMYTipsHelperHeight 60

@interface MYTipsView ()

@property (nonatomic,strong) UILabel *tipsLabel;

@end

@implementation MYTipsView

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
    [self addSubview:self.tipsLabel];
    self.width = kMYTipsHelperWidth;
    self.height = kMYTipsHelperHeight;
    self.backgroundColor = theMYWidget.itemViewColor;
    self.cornerRadius = 10;
}


#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.tipsLabel setSizeWithSize:CGSizeZero];
    self.tipsLabel.centerX = self.width * 0.5;
    self.tipsLabel.centerY = self.height * 0.5;
}

#pragma mark - --------------------功能函数------------------

+ (MYTipsView *)tipsViewWithTitle:(NSString *)text {
    MYTipsView *tipsView = [[MYTipsView alloc] init];
    tipsView.tipsLabel.text = text;
    [tipsView setNeedsLayout];
    return tipsView;
}

- (void)setText:(NSString *)text {
    self.tipsLabel.text = text;
    [self setNeedsLayout];
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

- (UILabel *)tipsLabel {
    if (!_tipsLabel) {
        _tipsLabel = [UILabel labelWithStyle:MYWidgetStyle_MYWidget_tt_c2_f3_a80 withTextAligment:NSTextAlignmentCenter];
    }
    return _tipsLabel;
}

@end
