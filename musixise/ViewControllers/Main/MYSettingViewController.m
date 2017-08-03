//
//  MYSettingViewController.m
//  musixise
//
//  Created by wmy on 2017/4/7.
//  Copyright © 2017年 wmy. All rights reserved.
//

#import "MYSettingViewController.h"
#import "MYSettingListModel.h"
#import "MYSettingDelegate.h"

@interface MYSettingViewController ()

@property (nonatomic, strong) MYSettingListModel *settingListModel;
@property (nonatomic, strong) MYSettingDelegate *settingDelegate;

@end

@implementation MYSettingViewController

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
}

- (void)initData {
    self.viewModel = self.settingListModel;
    self.title = @"设 置";
}

- (void)initView {
    self.tableviewDelegate = self.settingDelegate;
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

-(BOOL)refreshable {
    return NO;
}

- (BOOL)upRefreshable {
    return NO;
}

#pragma mark - --------------------功能函数------------------
#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

- (BOOL)playBarHidden {
    return YES;
}

- (MYSettingDelegate *)settingDelegate {
    if (!_settingDelegate) {
        _settingDelegate = [[MYSettingDelegate alloc] initWithTableView:self.tableView model:self.settingListModel];
    }
    return _settingDelegate;
}

- (MYSettingListModel *)settingListModel {
    if (!_settingListModel) {
        _settingListModel = [[MYSettingListModel alloc] init];
        //TODO: wmy test
        [_settingListModel test];
    }
    return _settingListModel;
}

@end
