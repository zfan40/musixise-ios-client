//
//  MYFavButton.m
//  musixise
//
//  Created by wmy on 2017/4/25.
//  Copyright © 2017年 wmy. All rights reserved.
//

#import "MYFavButton.h"
#import <MYWidget/MYWidget.h>
#import <MYUtils/UIView+MYAdditons.h>
#import <MYIconFont/MYButtonFactory.h>

@implementation MYFavButton

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    [MYButtonFactory setButtonImage:self
                      WithimageName:@"iconFont-youjiancaidanweishoucang"
                               size:24
                              color:theMYWidget.c0
                              state:UIControlStateNormal];
    
    [MYButtonFactory setButtonImage:self
                      WithimageName:@"iconFont-youjiancaidanshoucang"
                               size:24
                              color:theMYWidget.c0
                              state:UIControlStateNormal];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}

+ (instancetype)favButton {
    MYFavButton *favButton = [[MYFavButton alloc] init];
    favButton.width = 32;
    favButton.height = 32;
    return favButton;
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

@end
