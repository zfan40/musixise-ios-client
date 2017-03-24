//
//  MYPlayListManager.h
//  musixise
//
//  Created by wmy on 2017/3/23.
//  Copyright © 2017年 wmy. All rights reserved.
//  播放列表管理

#import <MYUtils/MYBasicSingleton.h>

#define thePlayListManager [MYPlayListManager sharedInstance]

@class MYWorkListModel;

@interface MYPlayListManager : MYBasicSingleton
//1. 设置列表管理选项

//2. 播放当前第几首
@property(nonatomic, assign) NSInteger playIndex;
//3. 播放开始选项
- (void)startPlaying;
//4. 播放结束选项
- (void)pause;
- (void)stop;

- (void)setListModel:(MYWorkListModel *)listModel;

- (void)setPlayIds:(NSArray<NSString *> *)array;

@end
