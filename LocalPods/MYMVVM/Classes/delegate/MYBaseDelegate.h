//
//  MYBaseDelegate.h
//  xiaplay
//
//  Created by wmy on 15/11/25.
//  Copyright © 2015年 wmy. All rights reserved.
//  抽象类,请不要直接用

#import <Foundation/Foundation.h>
#import "MYBaseViewModel.h"
#import "MYBaseTableView.h"
#import "MYBaseTableViewCell.h"
#import "MYBaseViewModel.h"
#import "MYNavigationController.h"
#import "MYBaseViewController.h"

@interface MYBaseDelegate : NSObject <UIViewControllerPreviewingDelegate>

@property(nonatomic,weak) MYBaseViewModel* model;

@property (nonatomic,weak) MYNavigationController *navigationController;

@property(nonatomic, weak) MYBaseViewController *vc;

- (MYBaseViewModel *)model;


@end

