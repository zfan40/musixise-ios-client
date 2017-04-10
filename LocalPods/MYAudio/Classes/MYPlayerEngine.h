//
//  MYPlayerUtils.h
//  musixise
//
//  Created by wmy on 2017/3/14.
//  Copyright © 2017年 wmy. All rights reserved.
//  播放引擎

#import <MYUtils/MYBasicSingleton.h>

#define thePlayEngine [MYPlayerEngine sharedInstance]

typedef void(^FinishBlock)();

@interface MYPlayerEngine : MYBasicSingleton
// 一首歌放完后的block
@property(nonatomic, copy) FinishBlock finishBlock;

- (void)inputPlayerData:(NSData *)data;

- (void)start;

- (void)pause;

- (void)stop;



@end
