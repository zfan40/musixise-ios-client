//
//  MYSoundManager.m
//  Pods
//
//  Created by wmy on 2017/4/7.
//
//

#import "MYSoundManager.h"
#import <MYUtils/MYJSONUtil.h>
#import "MYSoundModel.h"
#import <MYUtils/NSMutableDictionary+ALMSafe.h>
#import <MYUtils/NSMutableArray+ALMSafe.h>

@interface MYSoundManager ()

@property (nonatomic, strong) NSMutableArray<NSString *> *soundNames;
@property (nonatomic, strong) NSMutableDictionary<NSString *,MYSoundModel *> *soundModelDict;

@end

@implementation MYSoundManager


#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (instancetype)init {
    if (self = [super init]) {
        [self setupModels];
    }
    return self;
}

- (void)setupModels {
    //TODO: wmy 从文件中读取
    [self.soundNames removeAllObjects];
    [self.soundModelDict removeAllObjects];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"sounds" ofType:@"json"];
    NSArray *soundArray = [[MYJSONUtil sharedInstance] arrayWithJSONFilePath:filePath forKey:@"sounds"];
    NSAssert(soundArray.count, @"bundle 文件已损坏");
    if (soundArray.count) {
        for (NSDictionary *dict in soundArray) {
            MYSoundModel *model = [[MYSoundModel alloc] init];
            model.fileName = [dict objectForKey:@"fileName"];
            model.soundName = [dict objectForKey:@"soundName"];
            model.playManager = [[BPlayerAudioManager alloc] initWithVoice:model.fileName];
            [self.soundNames addObjectForMY:model.soundName];
            [self.soundModelDict setObjectForMY:model forKey:model.soundName];
        }
        NSAssert(self.soundModelDict.allKeys.count == self.soundNames.count, @"解析出现问题");
    }
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------
#pragma mark - --------------------功能函数------------------

- (NSArray<NSString *> *)soundNameArray {
    return self.soundNames;
}

- (BPlayerAudioManager *)managerWithSoundName:(NSString *)soundName {
    MYSoundModel *soundModel = [self.soundModelDict objectForKey:soundName];
    if (soundModel) {
        return soundModel.playManager;
    }
    return nil;
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    if (self.soundNames.count <= currentIndex ||
        self.currentIndex < 0) {
        NSLog(@"当前设置有问题 currentIndex = %d",currentIndex);
    } else {
        _currentIndex = currentIndex;
    }
}

- (BPlayerAudioManager *)currentManager {
    MYSoundModel *soundModel = [self.soundModelDict objectForKey:[self.soundNames objectAtIndex:self.currentIndex]];
    return soundModel.playManager;
}

#pragma mark private




#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

- (NSMutableArray<NSString *> *)soundNames {
    if (!_soundNames) {
        _soundNames = [NSMutableArray<NSString *> arrayWithCapacity:5];
    }
    return _soundNames;
}

- (NSMutableDictionary<NSString *,MYSoundModel *> *)soundModelDict {
    if (!_soundModelDict) {
        _soundModelDict = [NSMutableDictionary<NSString *,MYSoundModel *> dictionaryWithCapacity:5];
    }
    return _soundModelDict;
}

@end
