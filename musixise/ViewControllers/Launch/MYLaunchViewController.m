//
//  MYLaunchViewController.m
//  musixise
//
//  Created by wmy on 16/9/28.
//  Copyright © 2016年 wmy. All rights reserved.
//  欢迎页

#import "MYLaunchViewController.h"

@interface MYLaunchViewController ()

@property (strong, nonatomic) UIScrollView *scrollView;

@end

@implementation MYLaunchViewController

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
    [self.view addSubview:self.scrollView];
    self.scrollView.bounds = self.view.bounds;
}


#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------
#pragma mark - --------------------功能函数------------------
#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        
#if DEBUG
        _scrollView.layer.borderColor = [UIColor blueColor].CGColor;
        _scrollView.layer.borderWidth = 1;
#endif
    }
    return _scrollView;
}


@end
