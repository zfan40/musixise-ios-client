//
//  TTProvinceModel.h
//  treeBank
//
//  Created by kebi on 16/4/23.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTBaseModel.h"

#define kTTProvinceDataChangedNotification @"kTTProvinceDataChangedNotification"

@interface TTProvinceModel : TTBaseModel
@property (nonatomic, assign)NSInteger provid;
@property (nonatomic, strong)NSString *provname;
@property (nonatomic, strong)NSString *provshortname;
-(void)parseData:(NSDictionary*)dics;
@end


@interface TTProvinceListModel : TTBaseModel
@property (nonatomic, strong)NSMutableArray *datas;
-(void)load;
@end