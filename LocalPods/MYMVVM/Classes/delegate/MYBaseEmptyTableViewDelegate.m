//
//  MYBaseEmptyTableViewDelegate.m
//  Pods
//
//  Created by wmy on 16/2/24.
//
//

#import "MYBaseEmptyTableViewDelegate.h"
#import <MYWidget/MYWidget.h>
#import <MYUtils/UIImage+MYImage.h>
#import "MYTableViewController.h"

@implementation MYBaseEmptyTableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MYBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MYCollectionDetailPictureItemView"];
    MYBaseItemView *itemView = nil;
    if (!cell) {
        itemView = [[MYBaseItemView alloc] initWithItemStyle:MYBaseItemViewStyleNOTitleBackground viewModel:nil];
        cell = [[MYBaseTableViewCell alloc] initWithItemView:itemView reuseIdentifier:@"MYCollectionDetailPictureItemView"];
    }
    cell.backgroundColor = [UIColor clearColor];
    itemView.backgroundColor = [UIColor clearColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.cellHeight;
}



- (void)setCellHeight:(CGFloat)cellHeight {
    _cellHeight = cellHeight;
    [self.tableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//#ifdef DEBUG
//    NSLog(@"scrollView.contentOffset.y = %f",scrollView.contentOffset.y);
//#endif
    // 将headerView悬停
    if (scrollView.contentOffset.y > 64) {
        scrollView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    }else {
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    CGFloat height = self.cellHeight;
    CGFloat y = scrollView.contentOffset.y + 64;
    if (y < 0) {
        y = 0;
    }
    if (y > height) {
        y = height;
    }
    CGFloat alpha = 100.0 / height * y / 100.0;
    if (alpha > 1) {
        alpha = 1;
    }
    if (scrollView.contentOffset.y <= 0) {
        alpha = 0;
    }
    if (alpha < 0) {
        alpha = 0;
    }
    UIImage *backgroundImage = [UIImage createImageWithColor:RGBA(245, 50, 115, alpha)];
    [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = backgroundImage;

    if (self.viewController) {
        [(MYTableViewController *)self.viewController tableDelegateCallBack:@{@"offsetY":@(-scrollView.contentOffset.y + self.cellHeight)}];
        DebugLog(@"offsetY = %f",-scrollView.contentOffset.y + self.cellHeight);
    }
}

@end
