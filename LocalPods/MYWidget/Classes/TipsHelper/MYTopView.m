//
//  MYTopView.m
//  Pods
//
//  Created by wmy on 16/2/2.
//
//

#import "MYTopView.h"
#import "UILabel+MYStyle.h"
#import <MYIconFont/MYButtonFactory.h>

#define kMYTopViewWidth kScreenWidth
#define kMYTopViewHeight 44

@interface MYTopView ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIButton *closeButton;

@end

@implementation MYTopView

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
    [self addSubview:self.titleLabel];
    [self addSubview:self.closeButton];
}

+ (MYTopView *)topView {
    MYTopView *topView = [[MYTopView alloc] init];
    topView.width = kMYTopViewWidth;
    topView.height = kMYTopViewHeight;
    return topView;
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.titleLabel setSizeWithSize:CGSizeZero];
    self.titleLabel.centerX = self.width * 0.5;
    self.titleLabel.centerY = self.height * 0.5;
    
    self.closeButton.right = kScreenWidth - theMYWidget.m3;
    self.closeButton.centerY = self.height * 0.5;
    
    
}

#pragma mark - --------------------功能函数------------------

- (void)setText:(NSString *)title {
    self.titleLabel.text = title;
    [self setNeedsLayout];
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithStyle:MYWidgetStyle_MYWidget_tt_c2_f3_a80 withTextAligment:NSTextAlignmentCenter];
        _titleLabel.numberOfLines = 1;
    }
    return _titleLabel;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        
        _closeButton = [MYButtonFactory buttonWithImageName:@"iconFont-tieziquxiaoguanbi" size:16 color:theMYWidget.c1_a50];
        _closeButton.width = 20;
        _closeButton.height = 20;
    }
    return _closeButton;
}


@end
