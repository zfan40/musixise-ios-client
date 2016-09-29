//
//  MYTableViewController.h
//  xiaplay
//
//  Created by wmy on 15/11/23.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import "MYBaseViewController.h"
#import "MYBaseTableViewDelegate.h"
#import "MYBaseTableView.h"
#import <MYUtils/MYSafeUtil.h>

@interface MYTableViewController : MYBaseViewController


@property (nonatomic,strong) MYBaseTableView *tableView;

@property (nonatomic,weak) MYBaseTableViewDelegate *tableviewDelegate;

@property (nonatomic,strong) NSArray *titleArray;


/**
 *  是否可以上拉加载更多
 */
@property (nonatomic,assign) BOOL upRefreshable;
/**
 *  是否可以下拉加载更多
 */
@property (nonatomic,assign) BOOL refreshable;
@property (nonatomic,assign) BOOL scrollEnabled;

- (void)tableDelegateCallBack:(NSDictionary *)dict;

- (void)clickMoreWithIndex:(NSInteger)index;
/**
 *  返回到顶部
 */
- (void)backToTop;
/**
 *  设置返回Item
 */
- (void)setBackItem;
- (void)setTitle:(NSString *)title;
- (void)back;

- (MYNoDataType)noDataType;

- (MYNoDataEmptyType)noDataEmptyType;

@end
