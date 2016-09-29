//
//  MYMainViewController.m
//  musixise
//
//  Created by wmy on 16/9/23.
//  Copyright © 2016年 wmy. All rights reserved.
//  第一个页面 用于loadweb页面

#import "MYMainViewController.h"
#import <MYIconFont/MYButtonFactory.h>

@interface MYMainViewController ()

@property (strong, nonatomic) UIButton *rightButton;

@end

@implementation MYMainViewController

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (void)viewDidLoad {
    self.url = @"http://m.musixise.com/stagelist";
    [super viewDidLoad];
    [self initData];
    [self initView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
}

- (void)initData {
    
}

- (void)initView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Musixise";
}


#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (BOOL)rightItemHidden {
    return NO;
}

- (MYNoDataType)noDataType {
    return MYNoDataViewType_Hidden;
}

- (MYNoDataEmptyType)noDataEmptyType {
    return MYNoDataEmptyType_Hidden;
}

#pragma mark - --------------------功能函数------------------

- (BOOL)isBarAlpha {
    return NO;
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------

- (void)onclickLogin {
    DebugLog(@"点击登录");
    [router routeUrl:@"treeBank://page/MYLoginViewController"];
    
}

#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setTitle:@"登录" forState:UIControlStateNormal];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_rightButton sizeToFit];
        UITapGestureRecognizer *myRightMoreTap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                        action:@selector(onclickLogin)];
        [_rightButton addGestureRecognizer:myRightMoreTap];
    }
    return _rightButton;
}


@end
