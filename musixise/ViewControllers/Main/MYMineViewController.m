//
//  MYMineViewController.m
//  musixise
//
//  Created by wmy on 2016/11/29.
//  Copyright © 2016年 wmy. All rights reserved.
//

#import "MYMineViewController.h"
#import <MYUserSystem/MYUserUtils.h>

#define kImageViewWidth 170
#define kImageViewTop 150

@interface MYMineViewController ()


@end

@implementation MYMineViewController

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
}

- (void)initData {
    MYUser *user = [MYUserUtils sharedInstance].user;
//    [self.iconImageView my_setImageWithURL:user.largeAvatar];
}

- (void)initView {
//    [self.view addSubview:self.iconImageView];
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (BOOL)isBarAlpha {
    return YES;
}

#pragma mark - --------------------功能函数------------------
#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

@end
