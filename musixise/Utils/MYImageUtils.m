//
//  MYImageUtils.m
//  musixise
//
//  Created by wmy on 2017/3/14.
//  Copyright © 2017年 wmy. All rights reserved.
//

#import "MYImageUtils.h"
#import <MYNetwork/MYBaseNetWorkUtil.h>
#import <MYUtils/MYFileUtil.h>

@implementation MYImageUtils

/**
 上传图片
 
 @param image 图片数据
 @param block 完成的block
 */
- (void)uploadImage:(UIImage * _Nonnull)image
       withComplete:(void (^_Nonnull)(NSDictionary *_Nonnull result, BOOL success, NSError *_Nullable error))block {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithCapacity:1];
    // 将文件保存为一个image图片，以时间戳为名
    NSString *fileName = [self tmpFile];
    [[NSFileManager defaultManager] createFileAtPath:fileName
                                            contents:UIImageJPEGRepresentation(image, 1.0f)
                                          attributes:nil];
    [paramDict setObject:[NSURL fileURLWithPath:fileName] forKey:@"files"];
    [[MYBaseNetWorkUtil sharedInstance] posthttpWithDictionary:paramDict
                                                    withMethod:@"picture/uploadPic"
                                                  withComplete:^(NSDictionary * _Nonnull result, BOOL success, NSError * _Nullable error) {
        
    }];
}

- (NSString *)tmpFile {
    NSString *fileName = [NSString stringWithFormat:@"%lf+%d.jpg", [[NSDate date] timeIntervalSince1970], rand()];
    return [[[MYFileUtil sharedInstance] tmpPath] stringByAppendingPathComponent:fileName];
}

@end
