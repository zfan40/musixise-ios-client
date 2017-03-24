//
//  MYFileUtil.h
//  xiaplay
//
//  Created by wmy on 15/12/17.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import "MYBasicSingleton.h"
#import "MYDubugLog.h"

@interface MYFileUtil : MYBasicSingleton
/**
 *  获取document路径
 *
 *  @return string
 */
- (NSString *)documentPath;
/**
 *  获取caches路径
 *
 *  @return string
 */
- (NSString *)cachePath;
/**
 *  获取tmp路径
 *
 *  @return string
 */
- (NSString *)tmpPath;

/**
 *  获取document文档下的songs目录下的文件
 *
 *  @param file 文件名
 *
 *  @return string
 */
- (NSString *)documentSongsFilePath:(NSString *)file;
- (NSString *)cacheSongsFilePath:(NSString *)file;
- (NSString *)documentPicturesFilePath:(NSString *)file;
/**
 *  创建歌曲文件
 *
 *  @param file 文件
 *
 *  @return 歌曲文件路径
 */
- (NSString *)makeSureSongsFileExist:(NSString *)file;
- (NSString *)makeSureCacheSongsFileExist:(NSString *)file;
- (NSString *)makeSurePictureFileExist:(NSString *)file;

- (NSString *)createlyricFile:(NSString *)file;

- (BOOL)isLyricFileExist:(NSString *)file;

- (BOOL)isSongFileExist:(NSString *)file;

- (BOOL)isCacheSongFileExist:(NSString *)file;

- (BOOL)isPictureFileExist:(NSString *)file;

- (BOOL)isDatabaseExist:(NSString *)file;

- (NSString *)createDBFile:(NSString *)fileName;


- (BOOL)renameFile:(NSString *)filePathFileName toFileName:(NSString *)newFilePathName;

@end
