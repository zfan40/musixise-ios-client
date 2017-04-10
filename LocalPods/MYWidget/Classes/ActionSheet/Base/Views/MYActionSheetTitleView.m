//
//  MYActionSheetTitleView.m
//  Pods
//
//  Created by wmy on 2017/4/5.
//
//

#import "MYActionSheetTitleView.h"
#import <MYUtils/MYSafeUtil.h>
#import <MYWidget/MYWidget.h>
#import <MYUtils/UIView+MYAdditons.h>

@interface MYActionSheetTitleView ()

// 标题
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation MYActionSheetTitleView

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
    [self addSubview:self.subTitleLabel];
    [self addSubview:self.lineView];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}

+ (instancetype)actionSheetWithTitle:(NSString *)title andSubTitle:(NSString *)subTitle {
    MYActionSheetTitleView *titleView = [[MYActionSheetTitleView alloc] init];
    [titleView setTitle:title];
    [titleView setSubTitle:subTitle];
    return titleView;
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
    if (isEmptyString(self.subTitleLabel.text)) {
        self.titleLabel.centerY = self.height * 0.5;
    } else {
        CGSize size = [self.subTitleLabel sizeThatFits:CGSizeMake(self.width - 15 * 2, MAXFLOAT)];
        self.subTitleLabel.size = size;
        CGFloat top = (self.height - (self.titleLabel.height + self.subTitleLabel.height + 2))/2;
        self.titleLabel.top = top;
        self.subTitleLabel.top = self.titleLabel.bottom + 2;
    }
    self.titleLabel.centerX = self.width * 0.5;
    self.subTitleLabel.centerX = self.width * 0.5;
    self.lineView.bottom = self.height;
    self.lineView.left = 0;
}

#pragma mark - --------------------功能函数------------------

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
    [self.titleLabel sizeToFit];
}

- (void)setSubTitle:(NSString *)subTitle {
    self.subTitleLabel.text = subTitle;
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
        _lineView.backgroundColor = theMYWidget.c3;
        
    }
    return _lineView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font =  theMYWidget.f4;
        _titleLabel.textColor = theMYWidget.c0;
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.font = theMYWidget.f3;
        _subTitleLabel.textColor = theMYWidget.c0;
        _subTitleLabel.numberOfLines = 0;
    }
    return _subTitleLabel;
}

@end
