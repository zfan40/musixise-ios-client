//
//  MYMusicViewController.m
//  musixise
//
//  Created by wmy on 2016/12/28.
//  Copyright © 2016年 wmy. All rights reserved.
//

#import "MYMusicViewController.h"

@interface MYMusicViewController ()

@property(nonatomic, strong) UILabel *titleLabel;

@end

@implementation MYMusicViewController

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
}

- (void)initData {
    
}

- (void)initView {
    //TODO: wmy UI
    [self.view addSubview:self.titleLabel];
#if DEBUG
    self.titleLabel.layer.borderWidth = 1;
    self.titleLabel.layer.borderColor = [UIColor redColor].CGColor;
#endif

    self.titleLabel.text = self.titleStr;
#if DEBUG
    self.view.layer.borderWidth = 1;
    self.view.layer.borderColor = [UIColor blueColor].CGColor;
#endif
    [self.titleLabel sizeToFit];
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.titleLabel.centerX = self.view.width * 0.5;
    self.titleLabel.centerY = self.view.height * 0.5;
}

#pragma mark - --------------------功能函数------------------
#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

newInstanceUILabel1(titleLabel, MYWidgetStyle_MYWidget_tt_c1_f2_a100)


@end
