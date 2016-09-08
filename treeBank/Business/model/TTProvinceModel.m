//
//  TTProvinceModel.m
//  treeBank
//
//  Created by kebi on 16/4/23.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTApiService.h"
#import "TTProvinceModel.h"
#import "TTRunTime.h"
#import "TTTipsHelper.h"
#import <libextobjc/EXTScope.h>

@implementation TTProvinceModel

- (void)parseData:(NSDictionary *)dics {
    self.provid = [[dics objectForKey:@"provId"] integerValue];
    self.provname = [dics objectForKey:@"provName"];
    self.provshortname = [dics objectForKey:@"provShortname"];
}

@end

@implementation TTProvinceListModel

- (id)init {
    self = [super init];
    if (self) {
        _datas = [NSMutableArray new];
    }
    return self;
}

- (void)load {
    @weakify(self)[theApiService postRequest:@"/member/provlist.htm"
                                   parameter:@{
                                       @"token": [TTRunTime instance].user.token,
                                       @"memberid": [TTRunTime instance].user.objId
                                   }
                                       block:^(id result, BOOL ret, NSError *error) {
                                           @strongify(self) BOOL status = [[result objectForKey:@"success"] boolValue];
                                           NSString *message = [result objectForKey:@"message"];
                                           if (status) {
                                               [self.datas removeAllObjects];
                                               NSArray *list = [result objectForKey:@"list"];
                                               for (NSDictionary *dics in list) {
                                                   TTProvinceModel *model = [TTProvinceModel new];
                                                   [model parseData:dics];
                                                   [self.datas addObject:model];
                                               }
                                               [[NSNotificationCenter defaultCenter]
                                                   postNotificationName:kTTProvinceDataChangedNotification
                                                                 object:nil];
                                           } else {
                                               [TTTipsHelper showTip:message];
                                           }

                                       }];
}

@end