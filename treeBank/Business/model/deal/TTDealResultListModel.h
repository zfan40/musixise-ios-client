//
//  TTDealResultListModel.h
//  treeBank
//
//  Created by kebi on 16/5/13.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTBaseModel.h"

typedef NS_ENUM(NSInteger, TTDealType) { TTDealType_CollectMoney, TTDealType_GetMoneyNow };

typedef NS_ENUM(NSInteger, TTDealPayState) {
    TTDealPayState_Default,
    TTDealPayState_Preparing,
    TTDealPayState_Paying,
    TTDealPayState_PaySuccess,
    TTDealPayState_PayFaild
};

typedef NS_ENUM(NSInteger, TTDealAuditState) {
    TTDealAuditState_Default,     //未审核
    TTDealAuditState_NoAudit,     //未审核
    TTDealAuditState_Auditding,   //审核中
    TTDealAuditState_Resign,      //重新签名
    TTDealAuditState_RePhoto,     //重新拍照
    TTDealAuditState_AuditFaild,  //审核拒绝
};

@interface TTDealItemModel : TTBaseModel

@property (nonatomic, assign) TTDealType dealType;
@property (nonatomic, assign) TTDealPayState dealPayState;
@property (nonatomic, assign) TTDealAuditState dealAuditState;
@property (nonatomic, strong) NSString *money;

@end

@interface TTDealResultListModel : TTBaseModel
@property (nonatomic, strong) NSMutableArray *datas;

@end
