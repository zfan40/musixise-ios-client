//
//  MYSingleChooseView.m
//  Pods
//
//  Created by wmy on 16/6/14.
//
//

#import "MYSingleChooseView.h"
#import <MYIconFont/MYButtonFactory.h>
#import "UILabel+MYStyle.h"

@interface MYSingleChooseView ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIButton *selectButton;
@property (nonatomic,strong) UIView *lineView;

@end

@implementation MYSingleChooseView

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
    [self addSubview:self.selectButton];
    [self addSubview:self.lineView];
}

+ (instancetype)singleChooseViewWithTitle:(NSString *)title {
    MYSingleChooseView *chooseView = [[MYSingleChooseView alloc] init];
    chooseView.titleLabel.text = title;
    [chooseView.titleLabel sizeToFit];
    [chooseView setNeedsLayout];
    return chooseView;
}



#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.left = theMYWidget.m4;
    self.titleLabel.centerY = self.height * 0.5;
    
    self.selectButton.right = self.width - theMYWidget.m4;
    self.selectButton.centerY = self.height * 0.5;
    
    self.lineView.width = self.width - theMYWidget.m4 * 2;
    self.lineView.bottom = self.height;
    self.lineView.left = theMYWidget.m4;
    
}

#pragma mark - --------------------功能函数------------------
#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

- (void)setHiddenLine:(BOOL)hiddenLine {
    _hiddenLine = hiddenLine;
    self.lineView.hidden = hiddenLine;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.height = theMYWidget.seperatorHeight;
        _lineView.backgroundColor = theMYWidget.seperatorColor;
    }
    return _lineView;
}

- (UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [MYButtonFactory buttonWithImageName:@"iconFont-quanjuxuanzhongduigou" size:14 color:theMYWidget.c0];
        _selectButton.width = 24;
        _selectButton.height = 24;
        
    }
    return _selectButton;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithStyle:MYWidgetStyle_MYWidget_tt_c2_f4_a100 withTextAligment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

- (void)setIsChoose:(BOOL)isChoose {
    _isChoose = isChoose;
    self.selectButton.hidden = !isChoose;
    if (isChoose) {
        self.titleLabel.widgetStyle = MYWidgetStyle_MYWidget_tt_c0_f4_a100;
    } else {
        self.titleLabel.widgetStyle = MYWidgetStyle_MYWidget_tt_c2_f4_a100;
    }
}

@end
