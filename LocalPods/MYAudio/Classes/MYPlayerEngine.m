//
//  MYPlayerUtils.m
//  musixise
//
//  Created by wmy on 2017/3/14.
//  Copyright © 2017年 wmy. All rights reserved.
//

#import "MYPlayerEngine.h"
#import <MYAudio/BAudioController.h>
#import <MYUtils/NSArray+MYSafe.h>
@interface MYPlayerEngine ()

//@property (nonatomic, strong) NSTimer *timer;
@property(nonatomic, assign) NSInteger index;
@property(nonatomic, assign) CGFloat lastTime;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) BAudioController *audioPlayer;
@property(nonatomic, assign) BOOL isPlaying;// 控制是否播放的开关

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
    self.dataArray = [array copy];
    self.index = 0;
    // 2. 解析string
    // 3. 播放
    
}

- (void)start {
    self.isPlaying = YES;
    [self onPlaying];
}

- (void)pause {
    self.isPlaying = NO;
}

- (void)stop {
    self.isPlaying = NO;
    self.index = 0;
    self.dataArray = nil;
    self.lastTime = 0;
}

#pragma mark - --------------------按钮事件------------------

- (void)onPlaying {
    //TODO: wmy
    NSArray *array = [self.dataArray objectAtIndex:self.index];
    double nowTime = [array[3] doubleValue] * 0.001;
    MusicDeviceMIDIEvent(self.audioPlayer.samplerUnit,
                         (uint32_t)[array[0] integerValue],
                         (uint32_t)[array[1] integerValue],
                         (uint32_t)[array[2] integerValue],
                         0);
    self.index++;
    if (self.index > self.dataArray.count - 1) {
        [self stop];
    } else {
        [self performSelector:@selector(onPlaying) withObject:self afterDelay:(nowTime - self.lastTime)];
        self.lastTime = nowTime;
    }
}

#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

- (BAudioController *)audioPlayer {
    if (!_audioPlayer) {
        _audioPlayer = [BAudioController new];
        [_audioPlayer setInputVolume:1.0 withBus:0];
    }
    return _audioPlayer;
}

@end
