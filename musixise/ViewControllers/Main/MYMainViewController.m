//
//  MYMainViewController.m
//  musixise
//
//  Created by wmy on 16/9/23.
//  Copyright © 2016年 wmy. All rights reserved.
//  第一个页面 用于loadweb页面

#import "MYMainViewController.h"
#import <MYIconFont/MYButtonFactory.h>

#import <MYNetwork/MYBaseNetWorkUtil.h>

@interface MYMainViewController ()


@end

@implementation MYMainViewController

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (void)viewDidLoad {
    self.url = @"http://m.musixise.com/stagelist";
    [super viewDidLoad];
    [self initData];
    [self initView];
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


#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

@end
