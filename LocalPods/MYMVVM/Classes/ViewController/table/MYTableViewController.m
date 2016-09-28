//
//  MYTableViewController.m
//  xiaplay
//
//  Created by wmy on 15/11/23.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import "MYTableViewController.h"
#import "MYNavigationController.h"
#import "MYBaseTableView.h"
#import <MJRefresh/MJRefresh.h>
#import <MYUtils/UIView+MYAdditons.h>
#import <MYWidget/MYWidget.h>
#import <MYUtils/UIImage+MYImage.h>
#import <MYUtils/MYDubugLog.h>
#import <MYWidget/UILabel+MYStyle.h>
#import <MYWidget/MYNoDataView.h>

@implementation MYTableViewController

#pragma mark - --------------------退出清空------------------

- (void)dealloc {
    InfoLog(@"%@被回收了",[self class]);
    self.tableView = nil;
    self.tableviewDelegate = nil;
}

#pragma mark - --------------------初始化--------------------

- (void)viewDidLoad {
    self.refreshable = YES;
    self.upRefreshable = YES;
    InfoLog(@"%@被创建了",[self class]);
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
    if (![self playBarHidden]) {
        self.tableView.height = self.tableView.height -  [router.navigationController.rootViewController playBar].height - 64;
    }
    //     设置下拉刷新
    if (self.refreshable) {
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            // 进入刷新状态后调用此block
            DebugLog(@"===================下拉刷新 %@===================",[self class]);
            if ([self.viewModel isKindOfClass:[MYBaseListModel class]]) {
                [(MYBaseListModel *)self.viewModel onClean];
            }
            self.viewModel.page = 1;
            if (self.viewModel.needLoad) {
                [self.viewModel beginRequest];
            } else {
                [self viewModelDataChanged];
            }
        }];
        [self.tableView.mj_header beginRefreshing];
    } else {
        [self.tableView.mj_header removeFromSuperview];
    }
    
    if (self.upRefreshable) {
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            DebugLog(@"===================上拉加载更多 %@===================",[self class]);
            if (self.viewModel.more) {
                [self.tableView.mj_footer setAutomaticallyHidden:self.viewModel.more];
                if (self.viewModel.needLoad) {
                    [self.viewModel beginRequest];
                } else {
                    [self viewModelDataChanged];
                }
                [self.tableView.mj_footer setAutomaticallyHidden:self.viewModel.more];
            } else {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            
        }];
    } else {
        [self.tableView.mj_footer removeFromSuperview];
    }
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.height = self.view.height;
}

- (void)viewModelDataChanged {
    [super viewModelDataChanged];
    [self.tableView.mj_footer setAutomaticallyHidden:self.viewModel.more];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.isBarAlpha) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.shadowImage = [UIImage new];
        self.view.height = kScreenHeight;
        self.tableView.height = kScreenHeight;
    } else {
        self.tableView.height = kScreenHeight - 64;
        if (!self.playBarHidden) {
            self.tableView.height -= 50;
        }
        [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:theMYWidget.c0]
                                                      forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.shadowImage = [UIImage createImageWithColor:theMYWidget.c0];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nil;
}

#pragma mark - --------------------功能函数------------------

- (MYNoDataType)noDataType {
    return MYNoDataViewType_No_NetWork;
}

- (MYNoDataEmptyType)noDataEmptyType {
    return MYNoDataEmptyType_Empty;
}

- (void)backToTop {
    [self.tableView scrollsToTop];
}

- (void)back {
    [router routeUrl:@"xiaplay://back"];
}

- (void)tableDelegateCallBack:(NSDictionary *)dict {
    
}

- (void)setBackItem {
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView setImage:[UIImage imageNamed:@"back"]];
    imageView.width = 40;
    imageView.height = 40;
    [self.navigationItem setBackBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:imageView]];
}

- (void)setTitle:(NSString *)title {
    UILabel *titleLabel = [UILabel labelWithStyle:MYWidgetStyle_MYWidget_tt_c2_f4_a100 withTextAligment:NSTextAlignmentCenter];
    [titleLabel setText:title];
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
    
    UITapGestureRecognizer *myTitleTap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                              action:@selector(backToTop)];
    [titleLabel addGestureRecognizer:myTitleTap];
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

- (void)setScrollEnabled:(BOOL)scrollEnabled {
    _scrollEnabled = scrollEnabled;
    self.tableView.scrollEnabled = scrollEnabled;
}

- (void)clickMoreWithIndex:(NSInteger)index {
    MYNavigationController *navigationController = (MYNavigationController *)self.navigationController;
    if (index == 0) {
        [navigationController backToRoot];
    }
}

- (void)setTableviewDelegate:(MYBaseTableViewDelegate *)tableviewDelegate {
    _tableviewDelegate = tableviewDelegate;
    self.tableView.delegate = tableviewDelegate;
    self.tableView.dataSource = tableviewDelegate;
    if ([self.navigationController isKindOfClass:[MYNavigationController class]]) {
        tableviewDelegate.navigationController = (MYNavigationController *)self.navigationController;
    }
}


- (MYBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[MYBaseTableView alloc] init];
        _tableView.bounces = YES;
    }
    return _tableView;
}

@end
