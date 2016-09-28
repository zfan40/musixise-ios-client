//
//  MYDownLoadImageUtil.h
//  xiaplay
//
//  Created by wmy on 15/11/25.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import "MYBasicSingleton.h"
#import <SDWebImage/SDWebImageManager.h>
#import <SDWebImage/SDWebImageDownloader.h>

@interface MYDownLoadImageUtil : MYBasicSingleton
/**
 *  下载图片工具类
 *
 *  @param urlString 下载地址
 *  @param options   图片品质
 *  @param progress  过程回调
 *  @param completes 结束回调
 */
- (void)downloadImage:(nonnull NSString *)urlString
              options:(SDWebImageOptions)options
             progress:(nullable SDWebImageDownloaderProgressBlock)progress
            completes:(nullable SDWebImageCompletionWithFinishedBlock)completes ;
/**
 *  清除图片缓存
 *
 *  @param block 成功回调
 */
- (void)clearAllImages:(nullable void(^)())block;

- (void)caculateCache:(nullable void(^)(NSUInteger fileCount, NSString *_Nonnull fileSize))completeBlock;

@end
