//
//  MYAppDelegateUtils.h
//  musixise
//
//  Created by wmy on 16/9/29.
//  Copyright © 2016年 wmy. All rights reserved.
//  专门用于处理各种启动相关的封装

#import <MYUtils/MYBasicSingleton.h>

@class MYBaseViewController;

@interface MYAppDelegateUtils : MYBasicSingleton

- (MYBaseViewController *)showViewController;

@end
