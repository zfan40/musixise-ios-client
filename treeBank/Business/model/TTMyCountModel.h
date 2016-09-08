//
//  TTMyCountModel.h
//  treeBank
//
//  Created by kebi on 16/4/23.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTBaseModel.h"
#import <Foundation/Foundation.h>

@interface TTMyCountItem : NSObject
@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *detailTitle;
@end

@interface TTMyCountModel : TTBaseModel
@property (nonatomic, strong) NSMutableArray *datas;
@end
