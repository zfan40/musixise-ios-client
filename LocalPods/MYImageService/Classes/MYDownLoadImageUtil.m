//
//  MYDownLoadImageUtil.m
//  xiaplay
//
//  Created by wmy on 15/11/25.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import "MYDownLoadImageUtil.h"
#import <SDWebImage/SDImageCache.h>

@interface MYDownLoadImageUtil ()

@property (nonatomic,strong) SDWebImageManager *manager;

@end

@implementation MYDownLoadImageUtil


#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------
#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------
#pragma mark - --------------------功能函数------------------

- (void)downloadImage:(nonnull NSString *)urlString
              options:(SDWebImageOptions)options
             progress:(SDWebImageDownloaderProgressBlock)progress
            completes:(SDWebImageCompletionWithFinishedBlock)completes {
    [self.manager downloadImageWithURL:[NSURL URLWithString:urlString] options:options progress:progress completed:completes];
}

- (void)clearAllImages:(void(^)())block {
    [self.manager.imageCache clearMemory];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [self.manager.imageCache clearDiskOnCompletion:^{
        if (!block) {
            block();
        }
    }];
}

- (void)caculateCache:(nullable void(^)(NSUInteger fileCount, NSString *fileSize))completeBlock {
    [self.manager.imageCache calculateSizeWithCompletionBlock:^(NSUInteger fileCount, NSUInteger totalSize) {
        if (completeBlock) {
            
        }
    }];
}
#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

- (SDWebImageManager *)manager {
    if (!_manager) {
        _manager = [SDWebImageManager sharedManager];
    }
    return _manager;
}

@end
