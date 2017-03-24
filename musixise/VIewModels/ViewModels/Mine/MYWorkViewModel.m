//
//  MYWorkViewModel.m
//  musixise
//
//  Created by wmy on 2016/12/25.
//  Copyright © 2016年 wmy. All rights reserved.
//

#import "MYWorkViewModel.h"
#import <libextobjc/EXTScope.h>
#import <MYAudio/MYPlayerEngine.h>
#import <MYNetwork/MYBaseNetWorkUtil.h>
#import <MYAudio/MYPlayerEngine.h>
#import <MYUtils/MYFileUtil.h>
#import <MYUtils/MYSafeUtil.h>
#import <MYUtils/NSDateFormatter+instance.h>
#import "MYWorkModel.h"

@implementation MYWorkViewModel

- (void)play {
    // 若没有txt，需要重新请求
    if (isEmptyString(self.url)) {
        @weakify(self);
        self.requestCallback = ^{
            @strongify(self);
            [self preparePlay];
        };
        self.method = [NSString stringWithFormat:@"work/detail/%ld",(long)self.objId];
        [self beginRequest];
    } else {
        // 若有txt 需要去下载歌曲，然后播放
        [self preparePlay];
    }
}

- (void)requestSuccess:(NSDictionary *)dict {
    NSError *error;
    MYWorkModel *workModel = [[MYWorkModel alloc] initWithDictionary:dict error:&error];
    [self setDataModel:workModel];
}

/**
 已经有了Txt的string
 */
- (void)preparePlay {
    if (isEmptyString(self.url)) {
        NSAssert(!isEmptyString(self.url), @"url is null");
    }
    // 查找是否有txt
    if ([[MYFileUtil sharedInstance] isCacheSongFileExist:[self workName]]) {
        [self onPlay];
    } else {
        // 下载txt
        NSString *txtPath = [self workNametemp];
        [[MYBaseNetWorkUtil sharedInstance] downloadFileWithOption:nil
                                                     withInferface:self.url
                                                         savedPath:txtPath
                                                   downloadSuccess:^(AFHTTPRequestOperation * _Nullable operation, id  _Nullable responseObject) {
                                                       // 修改名称
                                                       [[MYFileUtil sharedInstance] renameFile:txtPath toFileName:[self workName]];
                                                       [self onPlay];
                                                   } downloadFailure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nullable error) {
                                                       DebugLog(@"//TODO: wmy 需要做失败处理");
                                                   } progress:^(float progress, float total) {
                                                       
                                                   }];
    }
    // workID+时间戳
    
}

- (void)onPlay {
    // 1. 读取文件内容，转为nsdata
    NSError *error;
    NSString *iOSPath = [self workName];
    NSData *songData = [NSData dataWithContentsOfFile:iOSPath options:NSDataReadingMappedIfSafe error:&error];
//    NSString *content = [NSString stringWithContentsOfFile:iOSPath encoding:NSUTF8StringEncoding error:nil];
    // 2. 播放
    [[MYPlayerEngine sharedInstance] inputPlayerData:songData];
    [[MYPlayerEngine sharedInstance] start];
}

- (NSString *)workName {
    NSString *name = [NSString stringWithFormat:@"%ld.musixise",(long)self.objId];
    return [[MYFileUtil sharedInstance] cacheSongsFilePath:name];
}

- (NSString *)workNametemp {
    //TODO: wmy 给个时间戳
    NSString *name = [NSString stringWithFormat:@"%ld.tmpmusixise",(long)self.objId];
    return [[MYFileUtil sharedInstance] makeSureCacheSongsFileExist:name];
}

@end
