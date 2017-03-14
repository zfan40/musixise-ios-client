//
//  MYFileUtil.m
//  xiaplay
//
//  Created by wmy on 15/12/17.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import "MYFileUtil.h"
#import "NSArray+MYSafe.h"
#import "MYDubugLog.h"
#define kSongDictionary @"song"
#define kLyricDictionary @"lyric"
#define kPictureDictionary @"picture"
#define kDataBaseDictionary @"database"

@implementation MYFileUtil

- (NSString *)databasePath {
    return [[[MYFileUtil sharedInstance] documentPath] stringByAppendingPathComponent:kDataBaseDictionary];
}

- (NSString *)songPath {
    return [[[MYFileUtil sharedInstance] documentPath] stringByAppendingPathComponent:kSongDictionary];
}

- (NSString *)lyricPath {
    return [[[MYFileUtil sharedInstance] documentPath] stringByAppendingPathComponent:kLyricDictionary];
}

- (NSString *)picturePath {
    return [[[MYFileUtil sharedInstance] documentPath] stringByAppendingPathComponent:kPictureDictionary];
}

- (NSString *)documentPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndexForMY:0];
    return docDir;
}

- (NSString *)cachePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths objectAtIndexForMY:0];
    return cachesDir;
}

- (NSString *)tmpPath {
    NSString *tmpDir = NSTemporaryDirectory();
    return tmpDir;
}

- (BOOL)isPictureFileExist:(NSString *)file {
    return [[MYFileUtil sharedInstance] documentWithDictionary:[[MYFileUtil sharedInstance] picturePath] isExist:file];
}

- (BOOL)isSongFileExist:(NSString *)file {
    return [[MYFileUtil sharedInstance] documentWithDictionary:[[MYFileUtil sharedInstance] songPath] isExist:file];
}

- (BOOL)isDatabaseExist:(NSString *)file {
    return [[MYFileUtil sharedInstance] documentWithDictionary:[[MYFileUtil sharedInstance] databasePath] isExist:file];
}

- (BOOL)isLyricFileExist:(NSString *) file {
    return [[MYFileUtil sharedInstance] documentWithDictionary:[[MYFileUtil sharedInstance] lyricPath] isExist:file];
}
- (NSString *)createlyricFile:(NSString *)file {
    return [[MYFileUtil sharedInstance] createDocumentDictionary:[[MYFileUtil sharedInstance] lyricPath] withFile:file];
}

- (NSString *)createPictureFile:(NSString *)file {
    return [[MYFileUtil sharedInstance] createDocumentDictionary:[[MYFileUtil sharedInstance] picturePath] withFile:file];
}

- (NSString *)createSongsFile:(NSString *)file {
    return [[MYFileUtil sharedInstance] createDocumentDictionary:[[MYFileUtil sharedInstance] songPath] withFile:file];
}

- (NSString *)createDBFile:(NSString *)fileName {
    return [[MYFileUtil sharedInstance] createDocumentDictionary:[[MYFileUtil sharedInstance] databasePath] withFile:fileName];
}

- (NSString *)documentSongsFilePath:(NSString *)file {
    return [[[MYFileUtil sharedInstance] songPath] stringByAppendingPathComponent:file];
}
- (NSString *)documentPicturesFilePath:(NSString *)file {
    return [[[MYFileUtil sharedInstance] picturePath] stringByAppendingPathComponent:file];
}



#pragma mark 内部方法

/**
 *  判断path下某文件是否存在
 *
 *  @param file 文件名
 *
 *  @return 是否存在
 */
- (BOOL)documentWithDictionary:(NSString *)path isExist:(NSString *)file {
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        // 如果目录不存在，则不存在
        return NO;
    } else {
        NSString *result = [path stringByAppendingPathComponent:file];
        if ([[NSFileManager defaultManager] fileExistsAtPath:result]) {
            return YES;
        } else {
            return NO;
        }
    }
    
}
- (NSString *)createDocumentDictionary:(NSString *)path withFile:(NSString *)file {
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[MYFileUtil sharedInstance] createDictionary:path];
    }
    NSString *filePath = [path stringByAppendingPathComponent:file];
    if ([[MYFileUtil sharedInstance] documentWithDictionary:path isExist:file]) {
        DebugLog(@"%@ 文件已存在，不需要再创建了",file);
        return filePath;
    }
    BOOL isSuccess = [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
    NSAssert(isSuccess, @"文件创建失败");
    return filePath;
}

- (BOOL)createDictionary:(NSString *)path {
    return [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
}
@end
