//
//  BPlayerAudioManager.h
//  Pods
//
//  Created by wmy on 2017/4/7.
//
//

#import <AudioToolbox/MusicPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface BPlayerAudioManager : NSObject<AVAudioSessionDelegate> {
    AUGraph _processingGraph;
    AudioUnit _samplerUnit;
    AudioUnit _ioUnit;
    AudioUnit _mixerUnit;
    
    AVAudioSession * _audioSession;
    BOOL _suspended;
    BOOL _acceptMidiMessages;
    
}

@property (nonatomic, readwrite) AudioUnit samplerUnit;

- (instancetype)initWithVoice:(NSString *)voiceName;


-(void)resumeFromInterruption;
-(void)interrupt;
-(void)setInputVolume:(Float32)volume withBus:(AudioUnitElement)bus;

- (NSString *)voiceName;

@end
