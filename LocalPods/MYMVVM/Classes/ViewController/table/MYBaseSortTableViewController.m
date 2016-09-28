//
//  MYBaseSortTableViewController.m
//  xiaplay
//
//  Created by wmy on 15/12/18.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import "MYBaseSortTableViewController.h"
#import "MYBaseSortListModel.h"
#import "MYSortBarView.h"
#import "MYBaseSortTableViewDelegate.h"
#import <MYUtils/UIView+MYAdditons.h>
#import <MYWidget/MYWidget.h>

@interface MYBaseSortTableViewController () <MYSortBarViewDelegate,BaseSortSectionDelegate>

@property (nonatomic,strong) MYSortBarView *sortedView;

@end

@implementation MYBaseSortTableViewController

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewStyleGrouped;
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)viewModelDataChanged {
    [self.sortListModel sort];
    self.sortedView.sortArray = [[self sortListModel] indexArray];
    self.sortedView.right = kScreenWidth - theMYWidget.m3;
    self.sortedView.centerY = kScreenHeight * 0.5 - 64;
    [self.sortedView removeFromSuperview];
    [self.view addSubview:self.sortedView];
    [super viewModelDataChanged];
}

#pragma mark - --------------------功能函数------------------
#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------

#pragma mark BaseSortSectionDelegate

- (void)sortSection:(NSInteger)section {
    self.sortedView.index = section;
}

#pragma mark MYSortBarViewDelegate

- (void)sortBarView:(MYSortBarView *)sortBarView withIndex:(CGFloat)index {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:index];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

#pragma mark - --------------------属性相关------------------

- (MYBaseSortListModel *)sortListModel {
    return nil;
}

- (MYSortBarView *)sortedView {
    if (!_sortedView) {
        _sortedView = [[MYSortBarView alloc] init];
        _sortedView.delegate = self;
    }
    return _sortedView;
}

//- (void)setViewModel:(MYBaseSortListModel *)viewModel {
//    if (![viewModel isKindOfClass:[MYBaseSortListModel class]]) {
//        NSAssert(NO, @"viewModel is not subclass of MYBaseSortListModel");
//    } else {
//        [super setViewModel:viewModel];
//    }
//}

- (void)setTableviewDelegate:(MYBaseSortTableViewDelegate *)tableviewDelegate {
    if (![tableviewDelegate isKindOfClass:[MYBaseSortTableViewDelegate class]]) {
        NSAssert(NO, @"tableviewDelegate is not subclass of MYBaseSortTableViewDelegate");
    } else {
        tableviewDelegate.delegate = self;
        [super setTableviewDelegate:tableviewDelegate];
    }
}


@end
