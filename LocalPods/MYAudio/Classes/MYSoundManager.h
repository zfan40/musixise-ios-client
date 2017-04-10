//
//  MYSoundManager.h
//  Pods
//
//  Created by wmy on 2017/4/7.
//
//  音色管理

#import <MYUtils/MYBasicSingleton.h>

@class BPlayerAudioManager;

@interface MYSoundManager : MYBasicSingleton

@property(nonatomic, assign) NSInteger currentIndex;

- (NSArray<NSString *> *)soundNameArray;

- (BPlayerAudioManager *)managerWithSoundName:(NSString *)soundName;

- (BPlayerAudioManager *)currentManager;

@end
