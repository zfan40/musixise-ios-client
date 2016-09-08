//
//  TTBankViewController.m
//  treeBank
//
//  Created by kebi on 16/4/23.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTAreaTableViewCell.h"
#import "TTBankViewController.h"
#import "TTMyCountModel.h"
#import "TTMyMainTableViewCell.h"
#import "TTRankListModel.h"
#import "TTRouter.h"
#import "TTRunTime.h"
#import "TTUIViewAdditons.h"
#import "TTUser.h"
#import "TTUtility.h"

@interface TTBankViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation TTBankViewController {
    UITableView *_tableView;
    TTRankListModel *_listModel;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"银行";
    _listModel = [TTRankListModel new];
    [_listModel load];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDataChanged)
                                                 name:kTTRankListDataChangedNotification
                                               object:nil];
    _tableView = [UITableView new];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

- (void)onDataChanged {
    [_tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listModel.datas.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, tableView.width, 40)];
    lab.textAlignment = NSTextAlignmentLeft;
    lab.text = @"全部";
    return lab;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TTAreaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (!cell) {
        cell = [[TTAreaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:NSStringFromClass([self class])];
    }

    TTBankModel *model = [_listModel.datas objectAtIndex:indexPath.row];
    cell.title = model.bankShortname;
    cell.showIndicator = NO;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    TTBankModel *model = [_listModel.datas objectAtIndex:indexPath.row];
    if (self.bankBlock) {
        self.bankBlock(model);
        [self goBack:nil];
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _tableView.frame = CGRectMake(0, 64, self.view.width, self.view.height - 64);
}

@end
