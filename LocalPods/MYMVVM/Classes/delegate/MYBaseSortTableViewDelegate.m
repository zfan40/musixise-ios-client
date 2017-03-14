//
//  MYBaseSortTableViewDelegate.m
//  xiaplay
//
//  Created by wmy on 15/12/18.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import "MYBaseSortTableViewDelegate.h"
#import "MYBaseSortViewModel.h"
#import "MYBaseSortListModel.h"
#import <MYUtils/UIView+MYAdditons.h>
#import <MYUtils/NSArray+MYSafe.h>
  
#import <MYWidget/UILabel+MYStyle.h>

@implementation MYBaseSortTableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    MYBaseSortListModel *listModel = (MYBaseSortListModel *)self.model;
    return listModel.sortArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    MYBaseSortListModel *listModel = (MYBaseSortListModel *)self.model;
    NSDictionary *dict = [listModel.sortArray objectAtIndexForMY:section];
    NSArray *values = [[dict allValues] objectAtIndexForMY:0];
    return values.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MYBaseSortListModel *listModel = (MYBaseSortListModel *)self.model;
    NSArray *indexArray = listModel.indexArray;
    UIView *view = [[UIView alloc] init];
    view.width = kScreenWidth;
    view.height = theMYWidget.m3;
    view.backgroundColor = theMYWidget.itemViewColor;
    UILabel *label = [UILabel labelWithStyle:MYWidgetStyle_MYWidget_tt_c1_f2_a100 withTextAligment:NSTextAlignmentCenter];
    label.text = [indexArray objectAtIndex:section];
    [label setSizeWithSize:CGSizeZero];
    label.left = theMYWidget.m3;
    label.centerY = view.centerY;
    [view addSubview:label];
    return view;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    if ([self.delegate respondsToSelector:@selector(sortSection:)]) {
        [self.delegate sortSection:section];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return theMYWidget.m3;
}

@end
