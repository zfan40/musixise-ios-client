//
//  MYTopSelectorLabel.m
//  musixise
//
//  Created by wmy on 2016/11/29.
//  Copyright © 2016年 wmy. All rights reserved.
//

#import "MYTopSelectorLabel.h"

@interface MYTopSelectorLabel ()

@property(nonatomic, strong) id<MYTopSelectorModel> model;

@end

@implementation MYTopSelectorLabel

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
    self.textAlignment = NSTextAlignmentCenter;
}

+ (instancetype)topSelectorLabelWithModel:(id<MYTopSelectorModel>)model {
    MYTopSelectorLabel *label = [[MYTopSelectorLabel alloc] init];
    label.model = model;
    return label;
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
}

#pragma mark - --------------------功能函数------------------
#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

- (void)setModel:(id<MYTopSelectorModel>)model {
    _model = model;
    self.text = model.title;
    self.textColor = model.normalColor;
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    self.textColor = selected ? self.model.selectedColor : self.model.normalColor;
}


@end
