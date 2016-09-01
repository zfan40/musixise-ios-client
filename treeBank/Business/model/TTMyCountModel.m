//
//  TTMyCountModel.m
//  treeBank
//
//  Created by kebi on 16/4/23.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTMyCountModel.h"
#import "TTUser.h"
#import "TTRunTime.h"

@implementation TTMyCountItem



@end

@implementation TTMyCountModel

-(id)init{
    self =[ super init];
    [self updateDatas];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onUserChanged) name:kTTUserChangedNotification  object:nil];
    return  self;
}
-(void)onUserChanged{
    [self updateDatas];
}

-(NSString*)authenticatText:(TTAuthStatus)status{
    NSString *text = @"未校验";
    switch (status) {
        case TTAuthStatus_N0:
            text = @"未校验";
            break;
        case TTAuthStatus_Authing:
            text = @"校验中";
            break;
        case TTAuthStatus_AuthedSuccess:
            text = @"已校验";
            break;
        case TTAuthStatus_AuthFailed:
            text = @"校验失败";
            break;
        default:
            break;
    }
    return text;
}
-(NSString*)auditText:(TTAuditStatus)status{
    NSString *text = @"";
    switch (status) {
        case TTAuditStatus_Default:
            text = @"";
            break;
        case TTAuditStatus_Auditing:
            text = @"审核中";
            break;
        case TTAuditStatus_AuditedSuccess:
            text = @"已审核";
            break;
        case TTAuthStatus_AuditFailed:
            text = @"审核失败";
            break;
        default:
            break;
    }
    return text;
}
-(void)updateDatas{
    TTUser *user  =[TTRunTime instance].user;
    
    NSArray *array =@[@{@"logo":@"authenticate",@"title":@"实名认证",@"detailText":[self authenticatText:user.authstatus]},
                      @{@"logo":@"infoReview",@"title":@"信息审核",@"detailText":[self auditText:user.auditstatus]},
                      @{@"logo":@"myCard",@"title":[NSString stringWithFormat:@"我的银行卡(%d张)",user.banknum]},
                      @{@"logo":@"deviceManager",@"title":@"设备管理",@"detailText":user.deviceno?user.deviceno:@""},
                      @{@"logo":@"revisePassword",@"title":@"修改登录密码"},
                      @{@"logo":@"questions",@"title":@"常见问题"}];
    _datas =[NSMutableArray new];
    for ( NSDictionary*dic in array ){
        TTMyCountItem *item =[ TTMyCountItem new];
        item.logo = [dic objectForKey:@"logo"];
        item.title = [dic objectForKey:@"title"];
        item.detailTitle = [dic objectForKey:@"detailText"];
        [_datas addObject:item];
    }
}

@end
