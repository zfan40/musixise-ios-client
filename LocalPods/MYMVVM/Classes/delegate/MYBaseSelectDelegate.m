//
//  MYBaseSelectDelegate.m
//  Pods
//
//  Created by wmy on 16/8/26.
//
//

#import "MYBaseSelectDelegate.h"

@interface MYBaseSelectDelegate ()

@property (nonatomic,weak) NSMutableArray<MYBaseTableViewDelegate *> *selectionDelegates;
@property (nonatomic,weak) MYBaseMergeViewModel *mergeViewModel;
@property (nonatomic,weak) MYBaseTableViewDelegate *currentDelegate;

@end

@implementation MYBaseSelectDelegate

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (instancetype)initWithTableView:(MYBaseTableView *)tableView
                    withDelegates:(NSArray<MYBaseTableViewDelegate *> *)delegates {
    if (self = [super init]) {
        NSAssert(tableView, @"tableView is nil");
        self.tableView = tableView;
        [self.selectionDelegates addObjectsFromArray:delegates];
        if (delegates.count) {
            [self selectWithIndex:0];
        }
    }
    return self;
}

- (instancetype)initWithTableView:(MYBaseTableView *)tableView
                    withDelegates:(NSArray <MYBaseTableViewDelegate *>*)delegates
                       mergeModel:(MYBaseMergeViewModel *)mergeViewModel {
    if (self = [super init]) {
        [self.selectionDelegates addObjectsFromArray:delegates];
        NSAssert(mergeViewModel, @"mergeViewModel is nil");
        NSAssert(tableView, @"tableView is nil");
        self.mergeViewModel = mergeViewModel;
        self.tableView = tableView;
        if (delegates.count) {
            [self selectWithIndex:0];
        }
    }
    return self;
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------
#pragma mark - --------------------功能函数------------------

- (void)selectWithIndex:(NSInteger)index {
    NSAssert(index >=0 && index <self.selectionDelegates.count, @"index is illegal");
    self.currentDelegate = [self.selectionDelegates objectAtIndex:index];
    [self.tableView reloadData];
}

- (void)addDelegate:(MYBaseTableViewDelegate *)tableDelegate
              index:(NSInteger)index {
    NSAssert(tableDelegate, @"tableDelegate is nil");
    [self.selectionDelegates insertObject:tableDelegate atIndex:index];
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.currentDelegate tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.currentDelegate tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.currentDelegate tableView:tableView numberOfRowsInSection:section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.currentDelegate numberOfSectionsInTableView:tableView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.currentDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [self.currentDelegate tableView:tableView heightForFooterInSection:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self.currentDelegate tableView:tableView viewForFooterInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self.currentDelegate tableView:tableView heightForHeaderInSection:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self.currentDelegate tableView:tableView viewForHeaderInSection:section];
}

#pragma mark - --------------------属性相关------------------

- (NSMutableArray<MYBaseTableViewDelegate *> *)selectionDelegates {
    if (!_selectionDelegates) {
        _selectionDelegates = [NSMutableArray<MYBaseTableViewDelegate *> array];
    }
    return _selectionDelegates;
}

@end
