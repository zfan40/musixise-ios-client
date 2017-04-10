//
//  MYActionSheetBottomView.m
//  Pods
//
//  Created by wmy on 2017/4/5.
//
//

#import "MYActionSheetBottomView.h"
#import <MYWidget/MYWidget.h>
#import <MYUtils/UIView+MYAdditons.h>


@interface MYActionSheetBottomView ()

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *btnLabel;

@end

@implementation MYActionSheetBottomView

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    [self addSubview:self.lineView];
    [self addSubview:self.btnLabel];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}

+ (instancetype)actionSheetBottomViewWithTitle:(NSString *)title {
    MYActionSheetBottomView *bottomView = [[MYActionSheetBottomView alloc] init];
    return bottomView;
}
#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
    self.btnLabel.centerX = self.width * 0.5;
    self.btnLabel.centerY = self.height * 0.5;
    self.lineView.top = 0;
    self.lineView.left = 0;
}

#pragma mark - --------------------功能函数------------------

- (void)setTitle:(NSString *)title {
    self.btnLabel.text = title;
    [self.btnLabel sizeToFit];
    [self setNeedsLayout];
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

- (UILabel *)btnLabel {
    if (!_btnLabel) {
        _btnLabel = [[UILabel alloc] init];
        _btnLabel.numberOfLines = 0;
        _btnLabel.font =  theMYWidget.f3;
        _btnLabel.textColor = theMYWidget.c0;
    }
    return _btnLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
        _lineView.backgroundColor = theMYWidget.c3;
    }
    return _lineView;
}

@end
