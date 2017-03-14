//
//  MYMineViewController.m
//  musixise
//
//  Created by wmy on 2016/11/29.
//  Copyright © 2016年 wmy. All rights reserved.
//

#import "MYMineViewController.h"
#import <MYUserSystem/MYUserUtils.h>
#import "MYMineUserItemView.h"
#import <MYMVVM/MYBaseMergeTableViewDelegate.h>
#import <MYMVVM/MYBaseMergeViewModel.h>
#import "MYMineMainDelegate.h"
#import "MYWorkDelegate.h"
#import "MYWorkListModel.h"
#define kImageViewWidth 170
#define kImageViewTop 150

@interface MYMineViewController ()

@property(nonatomic, strong) MYBaseMergeTableViewDelegate *mergeDelegate;
@property(nonatomic, strong) MYBaseMergeViewModel *mergeViewModel;
@property(nonatomic, strong) MYMineMainDelegate *headerDelegate;
@property(nonatomic, strong) MYWorkDelegate *workDelegate;
@property(nonatomic, strong) MYWorkListModel *workListModel;
@property(nonatomic, strong) MYUser *user;

@end

@implementation MYMineViewController

newInstanceDelegate(MYMineMainDelegate, headerDelegate, self.tableView, self.user)

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
}

- (void)initData {
    //TODO: wmy Test
    self.user = [MYUserUtils sharedInstance].user;
    // 仅仅是为了编译能过
    if (!self.user) {
        self.user = [[MYUser alloc] init];
    }
    self.viewModel = self.workListModel;
    
}

- (void)initView {
    self.tableviewDelegate = self.mergeDelegate;
    // 注册3D Touch
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (BOOL)refreshable {
    return NO;
}

- (MYNoDataType)noDataType {
    return MYNoDataViewType_Hidden;
}

- (MYNoDataEmptyType)noDataEmptyType {
    return MYNoDataEmptyType_Hidden;
}

- (BOOL)isBarAlpha {
    return YES;
}

#pragma mark - --------------------功能函数------------------
#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

- (MYWorkListModel *)workListModel {
    if (!_workListModel) {
        _workListModel = [[MYWorkListModel alloc] initWithMethod:@"work/getList"];
    }
    return _workListModel;
}

- (MYBaseMergeViewModel *)mergeViewModel {
    if (!_mergeViewModel) {
        _mergeViewModel = [[MYBaseMergeViewModel alloc] initWithModels:@[self.user,self.workListModel]];
    }
    return _mergeViewModel;
}

- (MYWorkDelegate *)workDelegate {
    if (!_workDelegate) {
        _workDelegate = [[MYWorkDelegate alloc] initWithTableView:self.tableView
                                                            model:self.workListModel];
        _workDelegate.vc = self;
    }
    return _workDelegate;
}

- (MYBaseMergeTableViewDelegate *)mergeDelegate {
    if (!_mergeDelegate) {
        _mergeDelegate = [[MYBaseMergeTableViewDelegate alloc] initWithTableView:self.tableView
                                                                      mergeModel:self.mergeViewModel];
        [_mergeDelegate addDelegate:@[self.headerDelegate,self.workDelegate]];
    }
    return _mergeDelegate;
}

@end
