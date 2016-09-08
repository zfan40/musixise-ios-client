//
//  TTUser.h
//  treeBank
//
//  Created by kebi on 16/4/23.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TTAuthStatus) {
    TTAuthStatus_N0 = 0,
    TTAuthStatus_Authing,
    TTAuthStatus_AuthedSuccess,
    TTAuthStatus_AuthFailed,
};

typedef NS_ENUM(NSInteger, TTAuditStatus) {
    TTAuditStatus_Default = 0,
    TTAuditStatus_Auditing,
    TTAuditStatus_AuditedSuccess,
    TTAuthStatus_AuditFailed,
};

@interface TTUser : NSObject

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *objId;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, assign) TTAuthStatus authstatus;    //认证状态
@property (nonatomic, assign) TTAuditStatus auditstatus;  //审核状态
@property (nonatomic, assign) NSInteger banknum;
@property (nonatomic, strong) NSString *deviceno;
- (void)parseData:(NSDictionary *)dics;
@end
