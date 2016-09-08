//
//  BaseTableViewController.h
//  BaseViewModel
//
//  Created by go886 on 14-10-13.
//  Copyright (c) 2014年 go886. All rights reserved.
//

#import "BaseViewController.h"
#import <UIKit/UIKit.h>
@interface BaseTableViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource>
- (instancetype)initWithStyle:(UITableViewStyle)style;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic) BOOL clearsSelectionOnViewWillAppear;
@end
