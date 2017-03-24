//
//  MYWorkDelegate.m
//  musixise
//
//  Created by wmy on 2016/12/25.
//  Copyright © 2016年 wmy. All rights reserved.
//

#import "MYWorkDelegate.h"
#import "MYWorkItemView.h"
#import "MYWorkListModel.h"
#import "MYWorkViewModel.h"
#import "MYMusicViewController.h"

@implementation MYWorkDelegate

- (MYWorkViewModel *)viewModelWithIndexPath:(NSIndexPath *)indexPath {
    MYWorkListModel *listModel = [self listModel];
    MYWorkViewModel *viewModel = (MYWorkViewModel *)[listModel data:indexPath];
    return viewModel;
}

- (NSString *)workIdsWithViewModels {
    NSMutableString *str = [NSMutableString string];
    MYWorkListModel *listModel = [self listModel];
    for (MYWorkViewModel *viewModel in listModel.allData) {
        [str appendString:[NSString stringWithFormat:@"%ld-",(long)viewModel.objId]];
    }
    if (str.length > 1) {
        return [str substringToIndex:(str.length - 1)];
    }
    return str;
}

- (MYWorkListModel *)listModel {
    if ([self.model isKindOfClass:[MYWorkListModel class]]) {
        MYWorkListModel *listModel = (MYWorkListModel *)self.model;
        return listModel;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MYBaseItemView *itemView = nil;
    MYBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MYWorkItemView"];
    MYWorkViewModel *viewModel = [self viewModelWithIndexPath:indexPath];
    if (!cell) {
        itemView = [[MYWorkItemView alloc] initWithItemStyle:MYBaseItemViewStyleNOTitleBackground viewModel:viewModel];
        cell = [[MYBaseTableViewCell alloc] initWithItemView:itemView reuseIdentifier:@"MYWorkItemView"];
        [self.vc registerForPreviewingWithDelegate:self sourceView:cell];
    } else {
        itemView = cell.itemView;
        itemView.viewModel = viewModel;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MYWorkItemView heightForViewModel:[self viewModelWithIndexPath:indexPath]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    MYWorkListModel *listModel = (MYWorkListModel *)self.model;
    return [listModel allDataCount];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    MYWorkListModel *listModel = (MYWorkListModel *)self.model;
    if ([listModel allDataCount]) {
        return 1;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //TODO: wmy 点击播放
    NSString *routeUrl = [NSString stringWithFormat:@"musixise://play?ids=%@?index=%ld",[self workIdsWithViewModels],(long)indexPath.row];
    [router routeUrl:routeUrl];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

// 左滑
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        // 首先改变model
        [[self listModel] removeItem:indexPath];
        // 不需要主动退出编辑模式，上面更新view的操作完成后就会自动退出编辑模式
    }];
    return @[deleteAction];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// 3DTouch

- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell* )[previewingContext sourceView]];
    MYMusicViewController *musicViewController = [[MYMusicViewController alloc] init];
    musicViewController.titleStr = [self viewModelWithIndexPath:indexPath].content;
    return musicViewController;
}


@end
