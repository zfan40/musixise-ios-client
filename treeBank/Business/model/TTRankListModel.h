//
//  TTRankListModel.h
//  treeBank
//
//  Created by kebi on 16/4/23.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTBaseModel.h"

#define kTTRankListDataChangedNotification  @"kTTRankListDataChangedNotification"

@interface TTBankModel : TTBaseModel
@property (nonatomic ,strong) NSString *bankCode;
@property (nonatomic ,strong) NSString *bankShortname;
-(void)parseData:(NSDictionary*)dics;

@end

@interface TTRankListModel : TTBaseModel
@property (nonatomic, strong) NSMutableArray *datas;
-(void)load;
@end
