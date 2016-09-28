//
//  MYMultiTabItemView.m
//  Pods
//
//  Created by wmy on 16/7/26.
//
//

#import "MYMultiTabItemView.h"
#import <MYWidget/UILabel+MYStyle.h>
@interface MYMultiTabItemView ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *subTitleLabel;

@end

@implementation MYMultiTabItemView

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


- (void) initView {
    [self addSubview:self.titleLabel];
    [self addSubview:self.subTitleLabel];
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.centerY = self.height * 0.5;
    self.titleLabel.left = (self.width - self.titleLabel.width - self.subTitleLabel.width - theMYWidget.m2)/2;
    
    self.subTitleLabel.left = self.titleLabel.right + theMYWidget.m2;
    self.subTitleLabel.bottom = self.titleLabel.bottom;
}

#pragma mark - --------------------功能函数------------------

- (void)setTitle:(NSString *)title {
    //TODO: wmy
    self.titleLabel.text = title;
    [self.titleLabel sizeToFit];
    [self setNeedsLayout];
}

- (void)setSubTitle:(NSString *)subTitle {
    //TODO: wmy
    self.subTitleLabel.text = subTitle;
    [self.subTitleLabel sizeToFit];
    [self setNeedsLayout];
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    self.titleLabel.widgetStyle = selected ? MYWidgetStyle_MYWidget_tt_c2_f3_a80 : MYWidgetStyle_MYWidget_tt_c0_f3_a100;
    self.subTitleLabel.widgetStyle = selected ? MYWidgetStyle_MYWidget_tt_c2_f2_a50 : MYWidgetStyle_MYWidget_tt_c0_f2_a100;
}


newInstanceUILabel(titleLabel, _titleLabel, MYWidgetStyle_MYWidget_tt_c2_f3_a80)
newInstanceUILabel(subTitleLabel, _subTitleLabel, MYWidgetStyle_MYWidget_tt_c2_f2_a50)

@end
