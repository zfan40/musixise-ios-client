//
//  MYPlayListManager.m
//  musixise
//
//  Created by wmy on 2017/3/23.
//  Copyright © 2017年 wmy. All rights reserved.
//

#import "MYPlayListManager.h"
#import <libextobjc/EXTScope.h>
#import <MYAudio/MYPlayerEngine.h>
#import "MYWorkListModel.h"
#import "MYWorkViewModel.h"

@interface MYPlayListManager ()

@property (nonatomic, strong) MYWorkListModel *listModel;
@property(nonatomic, weak) MYWorkViewModel *viewModel;

@end

@implementation MYPlayListManager

- (void)startPlaying {
    // 1. 将当前的model放到引擎中
    [self onPlay];
    @weakify(self);
    thePlayEngine.finishBlock = ^{
        @strongify(self);
        self.playIndex++;
        [self onPlay];
    };
}

- (void)onPlay {
    if (self.playIndex < self.listModel.allDataCount && self.playIndex >= 0) {
        self.viewModel = (MYWorkViewModel *)[self.listModel data:[NSIndexPath indexPathForRow:self.playIndex inSection:0]];
        [self.viewModel play];
    }
}

- (void)pause {
    [thePlayEngine pause];
}

- (void)stop {
    [thePlayEngine stop];
    self.playIndex = 0;
}

- (void)setPlayIds:(NSArray<NSString *> *)workIds {
    NSMutableArray *viewModels = [NSMutableArray array];
    for (NSString *workIdStr in workIds) {
        MYWorkViewModel *workViewModel = [[MYWorkViewModel alloc] init];
        workViewModel.objId = [workIdStr integerValue];
        [viewModels addObject:workViewModel];
    }
    MYWorkListModel *listModel = [[MYWorkListModel alloc] init];
    [listModel addItems:viewModels];
    self.listModel = listModel;
}

- (void)setListModel:(MYWorkListModel *)listModel {
    _listModel = listModel;
    self.playIndex = 0;
    [thePlayEngine stop];
}

- (void)setPlayIndex:(NSInteger)playIndex {
    if (playIndex < 0 ||
        [self.listModel allDataCount] < playIndex) {
        DebugLog(@"当前设置的PlayIndex不符合");
        return;
    }
    _playIndex = playIndex;
    
}

@end
