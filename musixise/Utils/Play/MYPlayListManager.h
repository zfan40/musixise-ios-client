//
//  MYPlayListManager.h
//  musixise
//
//  Created by wmy on 2017/3/23.
//  Copyright © 2017年 wmy. All rights reserved.
//  播放列表管理

#import <MYUtils/MYBasicSingleton.h>
#import "MYPlayBarProtocol.h"

#define thePlayListManager [MYPlayListManager sharedInstance]

#define kStartPlayingNofitication @"StartPlayingNofitication"
#define kStopPlayingNofitication @"StopPlayingNofitication"
#define kNextSongNofitication @"NextSongNofitication"
#define kPreSongNofitication @"PreSongNofitication"
#define kStopSongNofitication @"StopSongNofitication"

@class MYWorkListModel;
@class MYWorkViewModel;

@interface MYPlayListManager : MYBasicSingleton

@property(nonatomic, assign) NSInteger playIndex;

@property (nonatomic, strong) MYWorkListModel *listModel;

- (void)startPlaying;

- (void)pause;
- (void)resume;
- (void)stop;
- (void)next;
- (void)pre;

- (MYWorkViewModel *)currentModel;
- (void)setPlayIds:(NSArray<NSString *> *)array;

- (void)changeModelWithType:(MYPlayerModeType)type;

@end
