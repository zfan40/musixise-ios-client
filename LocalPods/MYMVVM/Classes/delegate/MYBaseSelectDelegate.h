//
//  MYBaseSelectDelegate.h
//  Pods
//
//  Created by wmy on 16/8/26.
//
//

#import "MYBaseTableViewDelegate.h"

@class MYBaseMergeViewModel;

@interface MYBaseSelectDelegate : MYBaseTableViewDelegate

- (instancetype)initWithTableView:(MYBaseTableView *)tableView
                    withDelegates:(NSArray <MYBaseTableViewDelegate *>*)delegates;

- (instancetype)initWithTableView:(MYBaseTableView *)tableView
                    withDelegates:(NSArray <MYBaseTableViewDelegate *>*)delegates
                       mergeModel:(MYBaseMergeViewModel *)mergeViewModel;

- (void)addDelegate:(MYBaseTableViewDelegate *)tableDelegate index:(NSInteger)index;

- (void)selectWithIndex:(NSInteger)index;


@end


