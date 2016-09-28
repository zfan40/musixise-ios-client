//
//  MYItemMoreView.m
//  Pods
//
//  Created by wmy on 16/4/13.
//
//

#import "MYBottomWithIconView.h"
#import <MYIconFont/MYButtonFactory.h>
#import <MYWidget/UIButton+MYStyle.h>
#import "MYIconTextItem.h"
#import "MYWidget.h"
#import "UILabel+MYStyle.h"
#import "MYIconTextArrayView.h"





@interface MYBottomWithIconView ()

@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UIView *moreView;
@property (nonatomic,strong) MYIconTextArrayView *itemView;
@property (nonatomic,strong) UIButton *closeButton;
@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation MYBottomWithIconView

newInstanceUIView(backView,_backView)
newInstanceUIView(moreView, _moreView)
newInstanceUIButton(closeButton, _closeButton)
newInstanceUILabel(titleLabel, _titleLabel, MYWidgetStyle_MYWidget_tt_c2_f4_a80)

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
    // 默认为4行
    self.width = kScreenWidth;
    self.height = kScreenHeight;
    [self addSubview:self.backView];
    self.backView.backgroundColor = theMYWidget.maskColor;

    [self addSubview:self.moreView];
    
    [self.moreView addSubview:self.closeButton];
    [MYButtonFactory setButtonImage:self.closeButton WithimageName:@"iconFont-guanbi" size:14 color:theMYWidget.c2_a20];
    self.closeButton.width = 32;
    self.closeButton.height = 32;
    self.closeButton.top = theMYWidget.m4;
    self.closeButton.left = theMYWidget.m4;
    [self.moreView addSubview:self.titleLabel];
    self.moreView.backgroundColor = theMYWidget.backgroundColor;
    self.moreView.width = kScreenWidth;

    [self.closeButton addTarget:self action:@selector(onClickClose) forControlEvents:UIControlEventTouchUpInside];

#if DEBUG
    self.itemView.layer.borderWidth = 1;
    self.itemView.layer.borderColor = [UIColor blueColor].CGColor;
    self.titleLabel.layer.borderWidth = 1;
    self.titleLabel.layer.borderColor = [UIColor blueColor].CGColor;
    self.closeButton.layer.borderWidth = 1;
    self.closeButton.layer.borderColor = [UIColor blueColor].CGColor;
    self.moreView.layer.borderWidth = 1;
    self.moreView.layer.borderColor = [UIColor blueColor].CGColor;
#endif
}

+ (instancetype)bottomViewWithArray:(NSArray <MYItemMoreViewModel>*)array withTitle:(NSString *)title column:(NSInteger)column {
    MYBottomWithIconView *itemModelView = [[MYBottomWithIconView alloc] init];
    itemModelView.itemView = [MYIconTextArrayView iconTextArrayViewWithArray:array column:column];
    [itemModelView.moreView addSubview:itemModelView.itemView];
    itemModelView.titleLabel.text = title;
    itemModelView.moreView.height = theMYWidget.m4 * 2 + itemModelView.closeButton.height + itemModelView.itemView.height + theMYWidget.m5;
    [itemModelView setNeedsLayout];
    return itemModelView;
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.titleLabel sizeToFit];
    self.titleLabel.centerX = self.width * 0.5;
    self.titleLabel.top = theMYWidget.m5;
    self.moreView.width = self.width;
//    self.moreView.height = self.itemView.height + self.titleLabel.height + theMYWidget.m5;
    self.moreView.bottom = self.height;
    self.itemView.top = self.titleLabel.bottom + theMYWidget.m3;
    self.itemView.left = self.titleLabel.bottom;
    self.itemView.centerX = self.width * 0.5;
    
}
#pragma mark - --------------------功能函数------------------
- (void)updateIcon:(NSString *)iconFont withIndex:(NSInteger)index {
    
}

- (void)show {
    //TODO: wmy 动画
#if DEBUG
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor blueColor].CGColor;
#endif
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}

- (void)dismiss {
    //TODO: wmy 动画
    [self removeFromSuperview];

}



#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------

- (void)onClickClose {
    [self dismiss];
}

#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------



@end
