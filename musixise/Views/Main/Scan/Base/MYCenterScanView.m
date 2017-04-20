//
//  MYCenterScanLayer.m
//  musixise
//
//  Created by wmy on 2017/4/18.
//  Copyright © 2017年 wmy. All rights reserved.
//

#import "MYCenterScanView.h"
#import <MYUtils/CALayer+MYAdditions.h>
#import <MYWidget/MYWidget.h>

@interface MYCenterScanView ()

@end

@implementation MYCenterScanView

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.backgroundColor = theMYWidget.c0;
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------
#pragma mark - --------------------功能函数------------------
#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

@end
