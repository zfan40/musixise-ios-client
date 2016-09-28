//
//  MYBaseMergeTableViewDelegate.h
//  xiaplay
//
//  Created by wmy on 15/12/21.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import "MYBaseTableViewDelegate.h"
#import "MYBaseMergeViewModel.h"

@interface MYBaseMergeTableViewDelegate : MYBaseTableViewDelegate

- (instancetype)initWithTableView:(MYBaseTableView *)tableView
                       mergeModel:(MYBaseMergeViewModel *)mergeModel
                    mergeDelegate:(NSArray<MYBaseTableViewDelegate *> *)delegates;

- (instancetype)initWithTableView:(MYBaseTableView *)tableView mergeModel:(MYBaseMergeViewModel *)mergeModel;

- (void)addDelegate:(NSArray<MYBaseTableViewDelegate *> *)delegates;

@end
