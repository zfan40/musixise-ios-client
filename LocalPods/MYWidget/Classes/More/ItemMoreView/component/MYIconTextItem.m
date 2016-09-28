//
//  MYItemMoreViewItemView.m
//  Pods
//
//  Created by wmy on 16/4/13.
//
//

#import "MYIconTextItem.h"
#import "MYWidget.h"
#import "UILabel+MYStyle.h"
#import <MYIconFont/MYButtonFactory.h>

@interface MYIconTextItem ()

@property (nonatomic,strong) UIButton *iconfontButton;
@property (nonatomic,strong) UILabel *textLabel;


@end

@implementation MYIconTextItem

newInstanceUILabel(textLabel, _textLabel,MYWidgetStyle_MYWidget_tt_c2_f3_a80)
newInstanceUIButton(iconfontButton, _iconfontButton)
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
    [self addSubview:self.iconfontButton];
    [self addSubview:self.textLabel];
    self.iconfontButton.width = 32;
    self.iconfontButton.height = 32;
}

+ (instancetype)itemMoreViewItemViewWithIconfont:(NSString *)iconfont title:(NSString *)title {
    MYIconTextItem *itemView = [[MYIconTextItem alloc] init];
    [itemView updateIconFont:iconfont];
    [itemView setTitle:title];
    return itemView;
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
    self.iconfontButton.centerX = self.width * 0.5;
    self.textLabel.top = self.iconfontButton.bottom + theMYWidget.m2;
    self.textLabel.centerX = self.width * 0.5;
    
}

#pragma mark - --------------------功能函数------------------

- (void)updateIconFont:(NSString *)iconfont {
    [MYButtonFactory setButtonImage:self.iconfontButton WithimageName:iconfont size:32 color:theMYWidget.c2_a80];
}

- (void)setTitle:(NSString *)title {
    self.textLabel.text = title;
    [self.textLabel sizeToFit];
    [self setNeedsLayout];
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------


@end
