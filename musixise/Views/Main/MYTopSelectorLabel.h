//
//  MYTopSelectorLabel.h
//  musixise
//
//  Created by wmy on 2016/11/29.
//  Copyright © 2016年 wmy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYTopSelectorModel.h"

@interface MYTopSelectorLabel : UILabel

+ (instancetype)topSelectorLabelWithModel:(id<MYTopSelectorModel>)model;

@property(nonatomic, assign) BOOL selected;

@end
