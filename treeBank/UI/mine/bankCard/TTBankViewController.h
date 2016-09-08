//
//  TTBankViewController.h
//  treeBank
//
//  Created by kebi on 16/4/23.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTViewController.h"

#import "TTRankListModel.h"

@interface TTBankViewController : TTViewController

@property (nonatomic, copy) void (^bankBlock)(TTBankModel *model);
@end
