//
//  TTRankListModel.m
//  treeBank
//
//  Created by kebi on 16/4/23.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTRankListModel.h"
#import "TTApiService.h"
#import "TTRunTime.h"
#import "TTTipsHelper.h"

@implementation TTBankModel

-(void)parseData:(NSDictionary*)dics{
    self.bankCode =[dics objectForKey:@"bankCode"];
    self.bankShortname =[dics objectForKey:@"bankShortname"];
}
@end

@implementation TTRankListModel

-(id)init{
    self =[super init];
    if(self){
        _datas =[NSMutableArray new];
    }
    return self;
}

-(void)load{
    [theApiService postRequest:@"/member/banklist.htm" parameter:@{@"token":[TTRunTime instance].user.token,@"memberid":[TTRunTime instance].user.objId} block:^(id result, BOOL ret, NSError *error) {
        BOOL status =[[result  objectForKey:@"success"]boolValue];
        if( status ){
            NSArray *list =[result objectForKey:@"list"];
            [_datas removeAllObjects];
            for( NSDictionary*dics in list ){
                TTBankModel *model =[TTBankModel new];
                [model parseData:dics];
                [_datas addObject:model];
            }
            [[NSNotificationCenter defaultCenter]postNotificationName:kTTRankListDataChangedNotification object:nil];
        }else{
            NSString *message =[result objectForKey:@"message"];
            [TTTipsHelper showTip:message];
        }
         
     }];

}

@end
