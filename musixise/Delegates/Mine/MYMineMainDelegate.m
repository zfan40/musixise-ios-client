//
//  MYMineMainDelegate.m
//  musixise
//
//  Created by wmy on 2016/12/24.
//  Copyright © 2016年 wmy. All rights reserved.
//

#import "MYMineMainDelegate.h"
#import <MYUserSystem/MYUser.h>
#import "MYMineUserItemView.h"

@implementation MYMineMainDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MYUser *user = (MYUser *)self.model;
    MYMineUserItemView *itemView = [[MYMineUserItemView alloc] initWithItemStyle:MYBaseItemViewStyleNOTitleBackground
                                                                       viewModel:user];
    MYBaseTableViewCell *cell = [[MYBaseTableViewCell alloc] initWithItemView:itemView reuseIdentifier:@"MYMineUserItemView"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MYMineUserItemView heightForViewModel:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//}

@end
