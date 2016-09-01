//
//  TTAuthModel.h
//  treeBank
//
//  Created by kebi on 16/4/23.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTBaseModel.h"

@interface TTAuthModel : TTBaseModel

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* idCard;

@property (nonatomic, strong) NSString* accountBankName;
@property (nonatomic, strong) NSString* accountBankId;
@property (nonatomic, strong) NSString* areaName;
@property (nonatomic, assign) NSInteger  provinceCardId;
@property (nonatomic, assign) NSInteger cityCardId;

@property (nonatomic, strong) NSString* bankName;
@property (nonatomic, strong) NSString* bankCard;
@property (nonatomic, strong) NSString* okBankCard;

@end
