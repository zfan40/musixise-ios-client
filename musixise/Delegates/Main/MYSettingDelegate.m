//
//  MYSettingDelegate.m
//  musixise
//
//  Created by wmy on 2017/4/7.
//  Copyright © 2017年 wmy. All rights reserved.
//

#import "MYSettingDelegate.h"
#import "MYSettingItemView.h"
#import "MYSettingListModel.h"
#import "MYSettingViewModel.h"

@implementation MYSettingDelegate

- (MYSettingListModel *)listModel {
    return (MYSettingListModel *)self.model;
}

- (MYSettingViewModel *)detailModelWithIndexPath:(NSIndexPath *)indexPath {
    MYSettingListModel *listModel = [self listModel];
    return (MYSettingViewModel *)[listModel data:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MYBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MYSettingItemView"];
    MYBaseItemView *itemView;
    MYSettingViewModel *viewModel = [self detailModelWithIndexPath:indexPath];
    if (!cell) {
        itemView = [[MYSettingItemView alloc] initWithItemStyle:MYBaseItemViewStyleNOTitleBackground viewModel:viewModel];
        cell = [[MYBaseTableViewCell alloc] initWithItemView:itemView reuseIdentifier:@"MYSettingItemView"];
    } else {
        itemView = cell.itemView;
        itemView.viewModel = viewModel;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self listModel].allDataCount;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MYSettingViewModel *viewModel = [self detailModelWithIndexPath:indexPath];
    if (!isEmptyString(viewModel.schemeUrl)) {
        [router routeUrl:viewModel.schemeUrl];
    }
}

@end
