//
//  CZNavigationController.h
//  xiaplay
//
//  Created by apple on 15-3-7.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYRootViewControllerProtocol.h"

@class MYRootViewController;

@interface MYNavigationController : UINavigationController

@property (nonatomic,weak) id<MYRootViewControllerProtocol> rootViewController;

- (void)backToRoot;
- (UIButton *)backButton;

@end
