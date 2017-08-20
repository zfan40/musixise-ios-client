//
//  MYPlayerBar.m
//  musixise
//
//  Created by wmy on 2017/4/24.
//  Copyright © 2017年 wmy. All rights reserved.
//

#import "MYPlayerBar.h"
#import <MYIconFont/MYButtonFactory.h>
#import <MYWidget/MYWidget.h>
#import <MYUtils/MYSafeUtil.h>

#define kSpace 16

@interface MYPlayerBar ()

@property (nonatomic, strong) UIButton *preBtn;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) UIButton *moreBtn;
@property (nonatomic, strong) UIButton *playModeBtn;
@property(nonatomic, assign) MYPlayerModeType modeType;

@end

@implementation MYPlayerBar


#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    [self addSubview:self.preBtn];
    self.userInteractionEnabled = YES;
    self.preBtn.width = 32;
    self.preBtn.height = 32;
    [MYButtonFactory setButtonImage:self.preBtn
                      WithimageName:@"iconFont-bofangqishangyiqu"
                               size:24
                              color:theMYWidget.c0
                              state:UIControlStateNormal];
    
    [self.preBtn addTarget:self action:@selector(onClickPre) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.nextBtn];
    self.nextBtn.width = 32;
    self.nextBtn.height = 32;
    [MYButtonFactory setButtonImage:self.nextBtn
                      WithimageName:@"iconFont-bofangqixiayiqu"
                               size:24
                              color:theMYWidget.c0
                              state:UIControlStateNormal];
    [self.nextBtn addTarget:self action:@selector(onClickNext) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.playBtn];
    self.playBtn.width = 32;
    self.playBtn.height = 32;
    [MYButtonFactory setButtonImage:self.playBtn
                      WithimageName:@"iconFont-bofangdan"
                               size:24
                              color:theMYWidget.c0
                              state:UIControlStateNormal];
    [MYButtonFactory setButtonImage:self.playBtn
                      WithimageName:@"iconFont-zantingdan"
                               size:24
                              color:theMYWidget.c0
                              state:UIControlStateSelected];
    [self.playBtn addTarget:self action:@selector(onClickPlay:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.moreBtn];
    self.moreBtn.width = 32;
    self.moreBtn.height = 32;
    [MYButtonFactory setButtonImage:self.moreBtn
                      WithimageName:@"iconFont-quanjugengduo"
                               size:24
                              color:theMYWidget.c0
                              state:UIControlStateNormal];
    [self.moreBtn addTarget:self action:@selector(onClickMore) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.playModeBtn];
    self.playModeBtn.width = 32;
    self.playModeBtn.height = 32;
    [MYButtonFactory setButtonImage:self.playModeBtn
                      WithimageName:@"iconFont-liebiaoxunhuan"
                               size:24
                              color:theMYWidget.c0
                              state:UIControlStateNormal];
    [self.playModeBtn addTarget:self action:@selector(onClickMode) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}

+ (instancetype)playerBar {
    MYPlayerBar *player = [[MYPlayerBar alloc] init];
    player.width = kScreenWidth;
    player.height = 100;
    return player;
}
#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
    self.playModeBtn.left = kSpace;
    self.playModeBtn.centerY = self.height * 0.5;
    
    self.preBtn.centerX = self.width * 0.25 + kSpace * 0.5;
    self.preBtn.centerY = self.height * 0.5;
    
    self.playBtn.centerX = self.width * 0.5;
    self.playBtn.centerY = self.height * 0.5;
    
    self.nextBtn.centerX = self.width * 0.75 - kSpace * 0.5;
    self.nextBtn.centerY = self.height * 0.5;
    
    self.moreBtn.right = self.width - kSpace;
    self.moreBtn.centerY = self.height * 0.5;
    
}

#pragma mark - --------------------功能函数------------------

- (void)setPreBtnSelected:(BOOL)selected {
    self.preBtn.selected = selected;
}

- (void)setNextBtnSelected:(BOOL)selected {
    self.nextBtn.selected = selected;
}

- (void)setPlay:(BOOL)isPlay {
    self.playBtn.selected = isPlay;
}

#pragma mark private

- (void)nextPlayModeType {
    self.modeType++;
    if (self.modeType == MYPlayerModeType_Count) {
        self.modeType = MYPlayerModeType_List;
    }
    NSString *iconfontName = nil;
    switch (self.modeType) {
            
        case MYPlayerModeType_List:
            iconfontName = @"iconFont-liebiaoxunhuan";
            break;
        case MYPlayerModeType_Random:
            iconfontName = @"iconFont-suijibofang";
            break;
        case MYPlayerModeType_Single:
            iconfontName = @"iconFont-danquxunhuan";
            break;
        default:
            break;
    }
    if (!isEmptyString(iconfontName)) {
        [MYButtonFactory setButtonImage:self.playModeBtn
                          WithimageName:iconfontName
                                   size:24
                                  color:theMYWidget.c0
                                  state:UIControlStateNormal];
    }
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------

- (void)onClickMode {
    [self nextPlayModeType];
    if ([self.delegate respondsToSelector:@selector(playerBar:didChangePlayMode:)]) {
        [self.delegate playerBar:self didChangePlayMode:self.modeType];
    }
}

- (void)onClickMore {
    if ([self.delegate respondsToSelector:@selector(playerBarDidClickMoreButton:)]) {
        [self.delegate playerBarDidClickMoreButton:self];
    }
}

- (void)onClickPlay:(UIButton *)button {
    button.selected = !button.isSelected;
    if ([self.delegate respondsToSelector:@selector(playerBar:didClickPlayButton:)]) {
        [self.delegate playerBar:self didClickPlayButton:button.selected];
    }
}

- (void)onClickPre {
    if ([self.delegate respondsToSelector:@selector(playerBarDidClickPreButton:)]) {
        [self.delegate playerBarDidClickPreButton:self];
    }
}

- (void)onClickNext {
    if ([self.delegate respondsToSelector:@selector(playerBarDidClickNextButton:)]) {
        [self.delegate playerBarDidClickNextButton:self];
    }
}


#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------


newInstanceUIButton1(preBtn)
newInstanceUIButton1(nextBtn)
newInstanceUIButton1(playBtn)
newInstanceUIButton1(moreBtn)
newInstanceUIButton1(playModeBtn)

@end
