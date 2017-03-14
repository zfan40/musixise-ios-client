//
//  MYPlayerUtils.h
//  musixise
//
//  Created by wmy on 2017/3/14.
//  Copyright © 2017年 wmy. All rights reserved.
//  播放引擎

#import <MYUtils/MYBasicSingleton.h>

@interface MYPlayerEngine : MYBasicSingleton

- (void)inputPlayerData:(NSData *)data;

- (void)start;

- (void)pause;

- (void)stop;

@end
