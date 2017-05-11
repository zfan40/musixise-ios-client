//
//  MYPlayerToolBarView.m
//  musixise
//
//  Created by wmy on 2017/4/25.
//  Copyright © 2017年 wmy. All rights reserved.
//

#import "MYPlayerToolBar.h"
#import <MYUtils/UIView+MYAdditons.h>
#import <MYWidget/MYWidget.h>
#import <MYIconFont/MYButtonFactory.h>
#import "MYCommentButton.h"
#import "MYFavButton.h"

@interface MYPlayerToolBar ()

@property (nonatomic, strong) MYCommentButton *commentBtn;
@property (nonatomic, strong) MYFavButton *favBtn;
@property (nonatomic, strong) UIButton *shareBtn;

@end

@implementation MYPlayerToolBar

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    [self addSubview:self.commentBtn];
    
    [self addSubview:self.favBtn];
    [MYButtonFactory setButtonImage:self.favBtn WithimageName:@"" size:24 color:theMYWidget.c0 state:UIControlStateNormal];
    
    [self addSubview:self.shareBtn];
    [MYButtonFactory setButtonImage:self.shareBtn WithimageName:@"" size:24 color:theMYWidget.c0 state:UIControlStateNormal];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}

+ (instancetype)playerToolBar {
    MYPlayerToolBar *view = [[MYPlayerToolBar alloc] init];
    
    
    return view;
}
#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
}

#pragma mark - --------------------功能函数------------------

- (void)setComment:(NSInteger)comment {
    [self.commentBtn setComment:comment];
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

- (MYCommentButton *)commentBtn {
    if (!_commentBtn) {
        _commentBtn = [MYCommentButton commentButton];
    }
    return _commentBtn;
}

- (MYFavButton *)favBtn {
    if (!_favBtn) {
        _favBtn = [MYFavButton favButton];
    }
    return _favBtn;
}

newInstanceUIButton1(shareBtn)

@end
