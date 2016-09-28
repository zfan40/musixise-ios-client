//
//  MYBaseTableViewDelegate.m
//  xiaplay
//
//  Created by wmy on 15/11/25.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import "MYBaseTableViewDelegate.h"
#import "MYBaseListModel.h"

@implementation MYBaseTableViewDelegate


- (instancetype)initWithTableView:(MYBaseTableView *)tableView model:(MYBaseViewModel *)model {
    if (self = [super init]) {
        self.model = model;
        self.tableView = tableView;
    }
    return self;
}

- (instancetype)initWithTableView:(MYBaseTableView *)tableView
                            model:(MYBaseViewModel *)model
                   viewController:(MYTableViewController *)viewController {
    if (self = [super init]) {
        self.model = model;
        self.tableView = tableView;
        self.viewController = viewController;
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.model isKindOfClass:[MYBaseListModel class]]) {
        return [(MYBaseListModel *)self.model allDataCount];
    } else {
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}
@end
