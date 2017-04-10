//
//  MYSettingListModel.m
//  musixise
//
//  Created by wmy on 2017/4/7.
//  Copyright © 2017年 wmy. All rights reserved.
//

#import "MYSettingListModel.h"
#import "MYSettingViewModel.h"
#import <MYAudio/MYSoundManager.h>

@implementation MYSettingListModel

- (MYSettingViewModel *)soundChangeModel {
    MYSettingViewModel *viewModel = [[MYSettingViewModel alloc] init];
    viewModel.title = @"音色设置";
    viewModel.schemeUrl = @"musixise://page/MYSoundSettingViewController";
    return viewModel;
}

- (void)test {
    self.mock = YES;
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:[self soundChangeModel]];
    for (int i = 0; i < 5; i++) {
        MYSettingViewModel *settingModel = [[MYSettingViewModel alloc] init];
        [settingModel test];
        [array addObject:settingModel];
    }
    [self addItems:array];
}

- (void)addSoundModels {
    NSArray *soundArray = [[MYSoundManager sharedInstance] soundNameArray];
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *sounds in soundArray) {
        MYSettingViewModel *settingModel = [[MYSettingViewModel alloc] init];
        settingModel.title = sounds;
        [array addObject:settingModel];
    }
    MYSettingViewModel *setModel = [array objectAtIndex:0];
    setModel.isSelect = YES;
    [self addItems:array];
}

@end
