//
//  TTDealPayModel.h
//  treeBank
//
//  Created by kebi on 16/4/24.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTBaseModel.h"

@interface TTDealPayModel : TTBaseModel

@property (nonatomic, strong) NSString *payMoney;
@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *businessType;
@property (nonatomic, strong) NSString *countRate;

@property (nonatomic, strong) NSString *tradeName;
@property (nonatomic, strong) NSString *bankCard;
@property (nonatomic, strong) NSString *cardHolderName;
@property (nonatomic, strong) NSString *mobile;

//@property (nonatomic, strong) UIImage *cardImage;
//@property (nonatomic, strong) UIImage *signedImage;

@end
