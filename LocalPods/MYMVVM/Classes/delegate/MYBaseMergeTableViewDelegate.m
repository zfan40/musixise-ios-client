//
//  MYBaseMergeTableViewDelegate.m
//  xiaplay
//
//  Created by wmy on 15/12/21.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import "MYBaseMergeTableViewDelegate.h"
#import "MYBaseListModel.h"

@interface MYBaseMergeTableViewDelegate ()

@property (nonatomic,strong) NSMutableArray *delegates;

@end

@implementation MYBaseMergeTableViewDelegate

- (instancetype)initWithTableView:(MYBaseTableView *)tableView mergeModel:(MYBaseMergeViewModel *)mergeModel {
    if (self = [super init]) {
        self.tableView = tableView;
        self.tableView.separatorStyle = UITableViewStylePlain;
        self.model = mergeModel;
    }
    return self;
}

- (instancetype)initWithTableView:(MYBaseTableView *)tableView mergeModel:(MYBaseMergeViewModel *)mergeModel mergeDelegate:(NSArray *)delegates{
    if (self = [super init]) {
        self.tableView = tableView;
        self.tableView.separatorStyle = UITableViewStylePlain;
        self.model = mergeModel;
        [self addDelegate:delegates];
    }
    return self;
}

- (void)addDelegate:(NSArray<MYBaseTableViewDelegate *> *)delegates {
    [self.delegates addObjectsFromArray:delegates];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegates) {
        MYBaseTableViewDelegate *delegate = [self.delegates objectAtIndex:indexPath.section];
        NSIndexPath *rowindexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
        if ([delegate respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)]) {
            return [delegate tableView:tableView cellForRowAtIndexPath:rowindexPath];
        }
    }
    return nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.delegates) {
        MYBaseTableViewDelegate *delegate = [self.delegates objectAtIndex:0];
        if ([delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
            [delegate scrollViewDidScroll:scrollView];
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (self.delegates) {
        MYBaseTableViewDelegate *delegate = [self.delegates objectAtIndex:section];
        if ([delegate respondsToSelector:@selector(tableView:viewForFooterInSection:)]) {
            return [delegate tableView:tableView viewForFooterInSection:0];
        }
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (self.delegates) {
        MYBaseTableViewDelegate *delegate = [self.delegates objectAtIndex:section];
        if ([delegate respondsToSelector:@selector(tableView:heightForFooterInSection:)]) {
            return [delegate tableView:tableView heightForFooterInSection:0];
        }
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.delegates) {
        MYBaseTableViewDelegate *delegate = [self.delegates objectAtIndex:section];
        if ([delegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
            return [delegate tableView:tableView viewForHeaderInSection:section];
        }
    }
    return nil;
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (self.delegates) {
//        MYBaseTableViewDelegate *delegate = [self.delegates objectAtIndex:indexPath.section];
//        if ([delegate respondsToSelector:@selector(tableView:estimatedHeightForRowAtIndexPath:)]) {
//            return [delegate tableView:tableView
//      estimatedHeightForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
//        }
//    }
//    return 0;
//}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
//    if (self.delegates) {
//        MYBaseTableViewDelegate *delegate = [self.delegates objectAtIndex:section];
//        if ([delegate respondsToSelector:@selector(tableView:estimatedHeightForHeaderInSection:)]) {
//            return [delegate tableView:tableView estimatedHeightForHeaderInSection:0];
//        }
//    }
//    return 0;
//}
//
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.delegates) {
         MYBaseTableViewDelegate *delegate = [self.delegates objectAtIndex:section];
        if ([delegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
            return [delegate tableView:tableView heightForHeaderInSection:section];
        }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegates) {
        MYBaseTableViewDelegate *delegate = [self.delegates objectAtIndex:indexPath.section];
        if ([delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
            return [delegate tableView:tableView heightForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
        }
    }
    return 0;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.delegates) {
        MYBaseTableViewDelegate *delegate = [self.delegates objectAtIndex:section];
        if ([delegate respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
            return [delegate tableView:tableView numberOfRowsInSection:0];
        }
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegates) {
        MYBaseTableViewDelegate *delegate = [self.delegates objectAtIndex:indexPath.section];
        if ([delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
            [delegate tableView:tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
            return;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.delegates) {
        return self.delegates.count;
    } else {
        return [(MYBaseMergeViewModel *)self.model count];
    }
}


- (NSMutableArray *)delegates {
    if (!_delegates) {
        _delegates = [NSMutableArray array];
    }
    return _delegates;
}

@end
