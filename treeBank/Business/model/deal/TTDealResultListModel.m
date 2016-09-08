//
//  TTDealResultListModel.m
//  treeBank
//
//  Created by kebi on 16/5/13.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTDealResultListModel.h"

@implementation TTDealItemModel

@end

@implementation TTDealResultListModel

- (id)init {
    self = [super init];
    self.datas = [NSMutableArray new];
    TTDealItemModel *itemModel = [TTDealItemModel new];
    itemModel.money = @"2000.00";
    itemModel.dealPayState = TTDealPayState_PaySuccess;
    itemModel.dealAuditState = TTDealAuditState_RePhoto;
    TTDealItemModel *itemModel1 = [TTDealItemModel new];
    itemModel1.money = @"3000.00";
    itemModel1.dealPayState = TTDealPayState_PaySuccess;
    itemModel1.dealAuditState = TTDealAuditState_RePhoto;

    [self.datas addObject:itemModel];
    [self.datas addObject:itemModel1];
    return self;
}

@end
