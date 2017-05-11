//
//  MYPlayButton.m
//  musixise
//
//  Created by wmy on 2017/4/21.
//  Copyright © 2017年 wmy. All rights reserved.
//

#import "MYPlayButton.h"
#import <MYUtils/UIView+MYAdditons.h>

#define kPlayWidth 24

@interface MYPlayButton ()

@property(nonatomic, assign) BOOL isStart;

@end

@implementation MYPlayButton

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    UITapGestureRecognizer *clickTap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                              action:@selector(onClick)];
    [self addGestureRecognizer:clickTap];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}

+ (instancetype)playButton {
    MYPlayButton *playBtn = [[MYPlayButton alloc] init];
    playBtn.width = kPlayWidth;
    playBtn.height = kPlayWidth;
    return playBtn;
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
}

#pragma mark - --------------------功能函数------------------

- (void)startAnimation {
    NSLog(@"");
}

- (void)stopAnimation {
    NSLog(@"");
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------

- (void)onClick {
    if (self.clickBlock) {
        self.clickBlock();
    }
}

#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

@end
