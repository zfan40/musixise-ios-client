//
//  MYBaseListModel.m
//  xiaplay
//
//  Created by wmy on 15/11/23.
//  Copyright © 2015年 wmy. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "MYBaseListModel.h"
#import "NSMutableArray+ALMSafe.h"
#import "NSArray+ALMSafe.h"

@interface MYBaseListModel ()
/**
 *  用于存放每个cell的viewModel
 */
@property (nonatomic,strong) NSMutableArray<MYBaseViewModel *> *viewModels;





@end

@implementation MYBaseListModel



#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------
#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------
#pragma mark - --------------------功能函数------------------


- (NSArray *)allData {
    return self.viewModels;
}

- (NSInteger)allDataCount {
    return self.viewModels.count;
}

- (MYBaseViewModel *)data:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    return [self.viewModels objectAtIndexForALM:row];
}

- (void)removeItem:(NSIndexPath *)indexPath {
    if (self.viewModels.count < indexPath.row) {
        ErrorLog(@"indexPath.row > self.items.count");
    } else {
        [self.viewModels removeObjectAtIndex:indexPath.row];
        [self emitDateChanged];
    }
}

- (void)addItems:(NSArray *)array {
    @synchronized(self) {
        [self.viewModels addObjectsFromArray:array];
    }
}


- (void)onClean {
    @synchronized(self) {
        self.page = 1;
        [self.viewModels removeAllObjects];
    }
}

- (void)refresh {
    [self onClean];
    [super refresh];
}

- (void)reload {
    [self onClean];
    [self dataBeginChanged];
    [super reload];
}


- (void)onRequestSuccess:(NSDictionary *)dict {
    [self requestSuccess:dict];
    [self dataEndChanged];
    
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

- (NSMutableArray<MYBaseViewModel *> *)viewModels {
    if (!_viewModels) {
        _viewModels = [NSMutableArray array];
    }
    return _viewModels;
}


@end
