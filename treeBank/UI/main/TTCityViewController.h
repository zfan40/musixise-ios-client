//
//  TTCityViewController.h
//  treeBank
//
//  Created by kebi on 16/4/23.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTViewController.h"
@class TTProvinceModel,TTCityModel;
@interface TTCityViewController : TTViewController
@property (nonatomic, copy) void(^block)(TTProvinceModel* model,TTCityModel *cityModel );
@property (nonatomic, strong)TTProvinceModel *model;
@end
