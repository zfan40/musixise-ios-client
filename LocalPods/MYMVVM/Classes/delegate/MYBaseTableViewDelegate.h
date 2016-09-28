//
//  MYBaseTableViewDelegate.h
//  xiaplay
//
//  Created by wmy on 15/11/25.
//  Copyright © 2015年 wmy. All rights reserved.
//  抽象类，请不要直接用

#import <UIKit/UIKit.h>
#import "MYBaseDelegate.h"
#import "MYBaseItemView.h"
#import "MYBaseTableViewCell.h"
#import <MYMVVM/MYRouter.h>

#define newInstanceDelegate(delegateClassName,delegateName,tableview,viewModel)  \
- (delegateClassName *)delegateName { \
    if (!_##delegateName) { \
        _##delegateName =[[delegateClassName alloc] initWithTableView:tableview model:viewModel]; \
    } \
    return _##delegateName; \
}


@class MYBaseViewController;
@class MYTableViewController;

@interface MYBaseTableViewDelegate :MYBaseDelegate <UITableViewDelegate,UITableViewDataSource,MYBaseViewModelDelegate>

@property (nonatomic,weak) MYBaseViewController *viewController;
@property (nonatomic,weak) MYBaseTableView *tableView;

- (instancetype)initWithTableView:(MYBaseTableView *)tableView model:(MYBaseViewModel *)model;
- (instancetype)initWithTableView:(MYBaseTableView *)tableView
                            model:(MYBaseViewModel *)model
                   viewController:(MYTableViewController *)viewController;

@end

