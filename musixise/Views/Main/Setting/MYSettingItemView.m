//
//  MYWorkItemView.m
//  musixise
//
//  Created by wmy on 2017/4/7.
//  Copyright © 2017年 wmy. All rights reserved.
//

#import "MYSettingItemView.h"
#import "MYSettingViewModel.h"

@interface MYSettingItemView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *selectBtn;

@end

@implementation MYSettingItemView

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    [self addSubview:self.titleLabel];
    [self addSubview:self.lineView];
    [self addSubview:self.selectBtn];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}
#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.left = 15;
    self.titleLabel.centerY = self.height * 0.5;
    self.lineView.bottom = self.height;
    self.lineView.left = 0;
    
    self.selectBtn.right = self.width - 15;
    self.selectBtn.centerY = self.height * 0.5;
}

#pragma mark - --------------------功能函数------------------

- (void)viewModelDataChanged {
    [super viewModelDataChanged];
    if ([self.viewModel isKindOfClass:[MYSettingViewModel class]]) {
        MYSettingViewModel *viewModel = (MYSettingViewModel *)self.viewModel;
        self.titleLabel.text = viewModel.title;
        [self.titleLabel sizeToFit];
        self.selectBtn.hidden = !viewModel.isSelect;
    }
    [self setNeedsLayout];
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

- (UIButton *)selectBtn {
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectBtn.width = 16;
        _selectBtn.width = 16;
        [MYButtonFactory setButtonImage:_selectBtn
                          WithimageName:@"iconFont-fensixuanze"
                                   size:16
                                  color:theMYWidget.c2_a50];
        _selectBtn.userInteractionEnabled = NO;
    }
    return _selectBtn;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.width = kScreenWidth;
        _lineView.height = 1;
        _lineView.backgroundColor = theMYWidget.c5;
    }
    return _lineView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = theMYWidget.c2;
        _titleLabel.font = theMYWidget.f3;
    }
    return _titleLabel;
}


@end
