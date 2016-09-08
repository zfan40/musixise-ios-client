//
//  TTMainViewController.m
//  treeBank
//
//  Created by kebi on 16/3/22.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTMainViewController.h"
#import "TTUIViewAdditons.h"
#import "TTMainBottomView.h"
#import "TTSettingViewController.h"
#import "TTMyMainViewController.h"
#import "TTBusinessViewController.h"
#import "TTMainPageViewController.h"

#import "TTIntroductionView.h"

@implementation TTMainViewController{
    TTMainBottomView *_bottomView;
    TTMainPageViewController *_mainPageViewController;
}

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

-(void)viewDidLoad{
    [super viewDidLoad];
    _mainPageViewController =[TTMainPageViewController new];
    [self.view addSubview:_mainPageViewController.view];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
}
#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    CGRect viewCt = self.view.bounds;
    viewCt.size.height = self.view.height;
    _mainPageViewController.view.frame = viewCt;
    
}

-(BOOL)shouldHideNavigationBar{
    return YES;
}
#pragma mark - --------------------功能函数------------------
#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------





@end
