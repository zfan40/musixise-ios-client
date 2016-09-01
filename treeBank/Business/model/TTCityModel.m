//
//  TTCityModel.m
//  treeBank
//
//  Created by kebi on 16/4/23.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTCityModel.h"
#import "TTApiService.h"
#import "TTRunTime.h"
#import <libextobjc/EXTScope.h>
#import "TTTipsHelper.h"



@implementation TTCityModel

-(void)parseData:(NSDictionary *)dics{
    self.cityid =[[ dics objectForKey:@"cityId"]integerValue];
    self.cityname =[dics objectForKey:@"cityName"];
    self.cityshortname = [dics objectForKey:@"cityShortname"];
}

@end


@implementation TTCityListModel
-(id)init{
    self =[super init];
    if(self){
        _datas =[NSMutableArray new];
    }
    return self;
}

-(void)load{
    @weakify(self)
    [theApiService  postRequest:@"/member/citylist.htm" parameter:@{@"token":[TTRunTime instance].user.token,@"memberid":[TTRunTime instance].user.objId,@"provid":@(self.provinceModel.provid)} block:^(id result, BOOL ret, NSError *error) {
        @strongify(self)
        BOOL status =[[result objectForKey:@"success"]boolValue];
        NSString *message =[result objectForKey:@"message"];
        if( status ){
            [self.datas removeAllObjects];
            NSArray *list =[result objectForKey:@"list"];
            for( NSDictionary *dics in list ){
                TTCityModel *model =[TTCityModel new];
                [model parseData:dics];
                [self.datas addObject:model];
            }
            [[NSNotificationCenter defaultCenter]postNotificationName:kTTCityDataChangedNotification  object:nil];
        }else{
            [TTTipsHelper showTip:message];
        }
        
    }];
    
}

@end