//
//  MYSettingViewModel.h
//  musixise
//
//  Created by wmy on 2017/4/7.
//  Copyright © 2017年 wmy. All rights reserved.
//

#import <MYMVVM/MYBaseViewModel.h>

@interface MYSettingViewModel : MYBaseViewModel

@property (nonatomic, strong) NSString *title;

@property(nonatomic, assign) BOOL isSelect;

@property (nonatomic, assign) SEL action;

@end
