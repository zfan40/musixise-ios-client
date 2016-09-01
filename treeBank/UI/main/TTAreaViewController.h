//
//  TTAreaViewController.h
//  treeBank
//
//  Created by kebi on 16/4/23.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTViewController.h"
@class TTProvinceModel, TTCityModel;
@interface TTAreaViewController : TTViewController
@property (nonatomic, copy) void(^provinceBlock)(TTProvinceModel* model,TTCityModel *cityModel );
@end
