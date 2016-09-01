//
//  TTCityModel.h
//  treeBank
//
//  Created by kebi on 16/4/23.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTBaseModel.h"
#import "TTProvinceModel.h"

#define kTTCityDataChangedNotification @"kTTCityDataChangedNotification"

@interface TTCityModel : TTBaseModel
@property (nonatomic, assign)NSInteger cityid;
@property (nonatomic, strong)NSString *cityname;
@property (nonatomic, strong)NSString *cityshortname;
-(void)parseData:(NSDictionary*)dics;
@end


@interface TTCityListModel : TTBaseModel
@property (nonatomic, strong)NSMutableArray *datas;
@property (nonatomic ,strong)TTProvinceModel *provinceModel;
-(void)load;
@end
