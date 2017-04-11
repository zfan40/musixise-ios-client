//
//  MYPlayerUtils.m
//  musixise
//
//  Created by wmy on 2017/3/14.
//  Copyright © 2017年 wmy. All rights reserved.
//

#import "MYPlayerEngine.h"
#import <MYUtils/NSArray+MYSafe.h>
#import "BPlayerAudioManager.h"
#import "MYSoundManager.h"

@interface MYPlayerEngine ()

//@property (nonatomic, strong) NSTimer *timer;
@property(nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) BPlayerAudioManager *audioPlayer;
@property(nonatomic, assign) BOOL isPlaying;// 控制是否播放的开关
@property(nonatomic, assign) CGFloat currentTime;
@property(nonatomic, assign) CGFloat totalTime;


@end

@implementation MYPlayerEngine


#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------
#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------
#pragma mark - --------------------功能函数------------------

- (void)setPlay:(BOOL)play {
    self.isPlaying = play;
}

#pragma mark - --------------------手势事件------------------

- (void)inputPlayerData:(NSData *)data {
    //TODO: wmy 需要改进,1. 边读边播放
    // 1. 判断string是否符合格式
    NSError *error;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    if (error) {
        //TODO: wmy 格式错误
        return;
    }
    self.dataArray = [array copy];
    self.index = 0;
    // 2. 解析string
    // 3. 播放
}

- (void)start {
    [self cancelPerform];
    self.isPlaying = YES;
    self.index = 0;
    [self onPlaying];
}

- (void)pause {
    self.isPlaying = NO;
}

- (void)stop {
    self.isPlaying = NO;
    self.index = 0;
    self.dataArray = nil;
    [self cancelPerform];
}

- (void)cancelPerform {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

#pragma mark - --------------------按钮事件------------------

- (void)onPlaying {
    //TODO: wmy
    NSArray *lastArray = [self.dataArray objectAtIndex:self.dataArray.count - 1];
    self.totalTime = [[lastArray objectAtIndex:3] floatValue];
    for (int i = self.index; i < self.dataArray.count; i++) {
        NSArray *array = [self.dataArray objectAtIndex:i];
        if (array.count == 4) {
            double nowTime = [array[3] doubleValue] * 0.001;
            [self performSelector:@selector(playInArray:) withObject:array afterDelay:nowTime];
        }
    }
}


- (void)playInArray:(NSArray *)array {
    self.index++;
    self.currentTime = [array[3] floatValue];
    if (self.currentTime == self.totalTime &&
        self.finishBlock) {
        self.finishBlock();
    }
    MusicDeviceMIDIEvent(self.audioPlayer.samplerUnit,
                         (uint32_t)[array[0] integerValue],
                         (uint32_t)[array[1] integerValue],
                         (uint32_t)[array[2] integerValue],
                         0);
}

#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

- (BPlayerAudioManager *)audioPlayer {
    return [MYSoundManager sharedInstance].currentManager;
}

@end
