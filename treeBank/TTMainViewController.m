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
    TTMyMainViewController *_myMainViewController;
    TTBusinessViewController *_businessViewController;
    TTMainPageViewController *_mainPageViewController;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
   
    _bottomView =[TTMainBottomView new];
    [self.view addSubview:_bottomView];
    [_bottomView.mainButton addTarget:self action:@selector(onMain) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView.mineButton addTarget:self action:@selector(onMine) forControlEvents:UIControlEventTouchUpInside];

    [_bottomView.businessButton addTarget:self action:@selector(onBusiness) forControlEvents:UIControlEventTouchUpInside];
    _myMainViewController =[TTMyMainViewController new];
    _businessViewController =[TTBusinessViewController new];
    _mainPageViewController =[TTMainPageViewController new];
    [self.view addSubview:_myMainViewController.view];
    [self.view addSubview:_businessViewController.view];
    [self.view addSubview:_mainPageViewController.view];
    _businessViewController.view.hidden = YES;
    _myMainViewController.view.hidden = YES;
    [_bottomView updateButton:_bottomView.mainButton selected:YES];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
}

-(BOOL)shouldHideNavigationBar{
    return YES;
}

-(void)onMain{
    _businessViewController.view.hidden = YES;
    _myMainViewController.view.hidden = YES;
    _mainPageViewController.view.hidden = NO;
    [_bottomView updateButton:_bottomView.mainButton selected:YES];
//    [[TTRouter defaultRouter]route:@"treeBank://interPage/TTLoginViewController" withParam:nil];
}

-(void)onMine{
    _bottomView.mineButton.selected = YES;
    _businessViewController.view.hidden = YES;
    _myMainViewController.view.hidden = NO;
    _mainPageViewController.view.hidden = YES;
    [_bottomView updateButton:_bottomView.mineButton selected:YES];


}

-(void)onBusiness{
    _businessViewController.view.hidden = NO;
    _myMainViewController.view.hidden = YES;
    _mainPageViewController.view.hidden = YES;
    [_bottomView updateButton:_bottomView.businessButton selected:YES];

}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    CGRect viewCt = self.view.bounds;
    viewCt.size.height = self.view.height;
    _bottomView.frame = CGRectMake(0, self.view.height, self.view.width, 0);
    _myMainViewController.view.frame = viewCt;
    _businessViewController.view.frame = viewCt;
    _mainPageViewController.view.frame = viewCt;

}


@end
