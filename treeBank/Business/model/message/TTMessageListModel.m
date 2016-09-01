//
//  TTMessageListModel.m
//  treeBank
//
//  Created by kebi on 16/4/28.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTMessageListModel.h"
#import "TTRunTime.h"
#import "TTApiService.h"
#import "TTTipsHelper.h"
#import <libextobjc/EXTScope.h>


@implementation TTMessageItemModel

-(void)parseData:(NSDictionary*)dics{
    _objId =[[dics objectForKey:@"id"]integerValue];
    _title = [dics objectForKey:@"title"];
    _content =[dics objectForKey:@"content"];
    _isrec =[[dics objectForKey:@"isrec"]boolValue];
}
@end

@implementation TTMessageListModel{
    NSInteger _page;
}

-(id)init{
    self =[super init];
    _page = 1;
    _datas  =[NSMutableArray new];
    return self;
}

-(void)load{
//    TTMessageItemModel *model =[TTMessageItemModel new];
//    [model parseData:nil];
//    TTMessageItemModel *model1 =[TTMessageItemModel new];
//    [model1 parseData:nil];
//    [self.datas addObject:model];
//    [self.datas addObject:model1];
//    [[NSNotificationCenter defaultCenter]postNotificationName:kTTMessageDataChangedNotification object:nil];
//    return;
    @weakify(self)
    [theApiService postRequest:@"/account/article.htm" parameter:@{@"token":[TTRunTime instance].user.token,@"memberid":[TTRunTime instance].user.objId,@"typecode":@"sysmsg",@"pagesize":@(20),@"pagenum":@(_page)} block:^(id result, BOOL ret, NSError *error) {
        @strongify(self)
        BOOL status =[[result objectForKey:@"success"]boolValue];
        NSArray *datas =[result objectForKey:@"list"];
        NSString *message = [result objectForKey:@"message"];
        if( status&&ret &&datas.count>0 ){
            _page++;
            for( NSDictionary *dics in datas ){
                TTMessageItemModel *model =[TTMessageItemModel new];
                [model parseData:dics];
                [self.datas addObject:model];
            }
            [[NSNotificationCenter defaultCenter]postNotificationName:kTTMessageDataChangedNotification object:nil];
        }else{
            [TTTipsHelper showTip:message];
        }
        
    }];

}
@end
