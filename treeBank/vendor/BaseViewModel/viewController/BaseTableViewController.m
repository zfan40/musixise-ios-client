//
//  BaseTableViewController.m
//  BaseViewModel
//
//  Created by go886 on 14-10-13.
//  Copyright (c) 2014年 go886. All rights reserved.
//

#import "BaseTableView.h"
#import "BaseTableViewController.h"
#import "BaseViewModel.h"

@interface BaseTableViewController ()
@end

@implementation BaseTableViewController {
    UITableViewStyle _tableStyle;
}
- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super init];
    if (self) {
        _tableStyle = style;
        _clearsSelectionOnViewWillAppear = YES;
    }

    return self;
}

- (void)setTableView:(UITableView *)tableView {
    _tableView = tableView;
    [self.view addSubview:tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_clearsSelectionOnViewWillAppear) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        if (indexPath) {
            [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITableView *table = [[UITableView alloc] initWithFrame:self.view.bounds style:_tableStyle];
    table.frame = self.view.bounds;
    table.delegate = self;
    table.dataSource = self;
    self.tableView = table;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)viewModelDataChanged {
    UITableView *tableview = self.tableView;
    if (tableview) {
        [tableview reloadData];
    }
}

#pragma UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.viewModel sectionCount];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel itemCount:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView cellForClass:[UITableViewCell class] style:UITableViewCellStyleDefault kIdentifier:nil];
}

@end
