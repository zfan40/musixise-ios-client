//
//  CZBadgeView.m
//  xiaplay
//
//  Created by apple on 15-3-5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "MYBadgeView.h"
#import <MYUtils/UIView+MYAdditons.h>
#import <MYUtils/MYSafeUtil.h>

#define kBadgeViewFont [UIFont systemFontOfSize:11]

@interface MYBadgeView ()


@end

@implementation MYBadgeView

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
    self.userInteractionEnabled = NO;
    // 设置字体大小
    self.titleLabel.font = kBadgeViewFont;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self sizeToFit];
}

+ (instancetype)badgeView {
    MYBadgeView *badgeView = [MYBadgeView buttonWithType:UIButtonTypeCustom];
    badgeView.width = 10;
    badgeView.height = 10;
    return badgeView;
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
}

#pragma mark - --------------------功能函数------------------
#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

- (void)setValue:(NSInteger)value {
    if (value > 0) {
        if (value > 999) {
            self.width = 15;
            [self setTitle:@"..." forState:UIControlStateNormal];
        } else if (value > 99) {
            self.width = 15;
            [self setTitle:@"99+" forState:UIControlStateNormal];
        } else {
            self.width = 10;
            [self setTitle:[NSString stringWithFormat:@"%d",value] forState:UIControlStateNormal];
        }
        self.hidden = NO;
    } else {
        self.hidden = YES;
    }
    
}


@end
