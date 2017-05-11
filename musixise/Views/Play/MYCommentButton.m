//
//  MYCommentButton.m
//  musixise
//
//  Created by wmy on 2017/4/25.
//  Copyright © 2017年 wmy. All rights reserved.
//

#import "MYCommentButton.h"
#import <MYUtils/UIView+MYAdditons.h>
#import <MYWidget/MYWidget.h>
#import <MYUtils/MYSafeUtil.h>
#import <MYIconFont/MYButtonFactory.h>
#import <MYWidget/UILabel+MYStyle.h>

@interface MYCommentButton ()

@property (nonatomic, strong) UILabel *commentLabel;

@end

@implementation MYCommentButton

newInstanceUILabel1(commentLabel, MYWidgetStyle_MYWidget_tt_c0_f1_a100)

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    [self addSubview:self.commentLabel];
    [self setComment:0];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}

+ (instancetype)commentButton {
    MYCommentButton *commentButton = [[MYCommentButton alloc] init];
    commentButton.width = 32;
    commentButton.height = 32;
    return commentButton;
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
}

#pragma mark - --------------------功能函数------------------

- (void)setComment:(NSInteger)commentNumber {
    NSString *str = nil;
    if (!commentNumber) {
        [MYButtonFactory setButtonImage:self
                          WithimageName:@"iconFont-pinglun"
                                   size:24
                                  color:theMYWidget.c0
                                  state:UIControlStateNormal];
    } else {
        [MYButtonFactory setButtonImage:self
                          WithimageName:@"iconFont-pinglun1"
                                   size:24
                                  color:theMYWidget.c0
                                  state:UIControlStateNormal];
        if (commentNumber > 1000) {
            str = @"999+";
        } else {
            str = [NSString stringWithFormat:@"%ld",(long)commentNumber];
        }
    }
    self.commentLabel.text = str;
    [self.commentLabel sizeToFit];
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

@end
