//
//  MYSettingListModel.m
//  musixise
//
//  Created by wmy on 2017/4/7.
//  Copyright © 2017年 wmy. All rights reserved.
//

#import "MYSettingListModel.h"
#import <MYAudio/MYSoundManager.h>
#import <MYWidget/MYActionSheet.h>
#import "MYSettingViewModel.h"
#import <MYAudio/MYSoundManager.h>

@interface MYSettingListModel () <MYActionSheetDelegate>

@end

@implementation MYSettingListModel

- (MYSettingViewModel *)soundChangeModel {
    MYSettingViewModel *viewModel = [[MYSettingViewModel alloc] init];
    viewModel.title = @"音色设置";
    viewModel.action = @selector(soundScheme);
    return viewModel;
}



- (void)soundScheme {
    NSArray *array = [[MYSoundManager sharedInstance] soundNameArray];
    MYActionSheet *actionSheet = [MYActionSheet actionSheetWithTitle:@"音色设置"
                                                             message:@"请选择播放时的音色"
                                                            delegate:self
                                                   cancelButtonTitle:@"取消"
                                                    buttonTitleArray:array];
    [actionSheet show];
}


- (void)actionSheet:(MYActionSheet *)actionSheet DidClickWithIndex:(NSInteger)index {
    [[MYSoundManager sharedInstance] setCurrentIndex:index];
    [actionSheet dismiss];
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
