//
//  MYSoundModel.h
//  Pods
//
//  Created by wmy on 2017/4/7.
//
//

#import <Foundation/Foundation.h>
#import "BPlayerAudioManager.h"

@interface MYSoundModel : NSObject

@property (nonatomic, strong) NSString *soundName;
@property (nonatomic, strong) BPlayerAudioManager *playManager;
@property (nonatomic, strong) NSString *fileName;

@end
