//
//  MYFavWorksOfArtViewController.m
//  musixise
//
//  Created by wmy on 2016/12/4.
//  Copyright © 2016年 wmy. All rights reserved.
//

#import "MYFavWorksOfArtViewController.h"

@interface MYFavWorksOfArtViewController ()

@end

@implementation MYFavWorksOfArtViewController

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
    self.view.backgroundColor = [UIColor blueColor];
}
#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (MYNoDataEmptyType)noDataEmptyType {
    return MYNoDataEmptyType_Hidden;
}

- (MYNoDataType)noDataType {
    return MYNoDataViewType_Hidden;
}

#pragma mark - --------------------功能函数------------------
#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

@end
