//
//  MYBaseNetWorkUtil.h
//  xiaplay
//
//  Created by wmy on 15/11/25.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import "MYBasicSingleton.h"
#import "MYNetWorkEnums.h"

@class AFHTTPRequestOperation;



@interface MYBaseNetWorkUtil : MYBasicSingleton

- (MYNetWorkStatus)status;


/**
 *  get请求
 *
 *  @param dict   参数
 *  @param method method
 *  @param block  回调
 */
- (AFHTTPRequestOperation *_Nullable)gethttpWithDictionary:(nonnull NSDictionary *)dict
                   withMethod:(NSString * _Nonnull)method
                 withComplete:(void (^ _Nonnull)(NSDictionary *_Nonnull result, BOOL success, NSError *_Nullable error))block;

/**
 *  post请求
 *
 *  @param dict   参数
 *  @param method method
 *  @param block  回调
 */
- (AFHTTPRequestOperation *_Nullable)posthttpWithDictionary:(nonnull NSDictionary *)dict
                    withMethod:(NSString *_Nonnull)method
                  withComplete:(void (^_Nonnull)(NSDictionary *_Nonnull result, BOOL success, NSError *_Nullable error))block;


/**
 *  @author Jakey
 *
 *  @brief  下载文件
 *
 *  @param paramDic   附加post参数
 *  @param requestURL 请求地址
 *  @param savedPath  保存 在磁盘的位置
 *  @param success    下载成功回调
 *  @param failure    下载失败回调
 *  @param progress   实时下载进度回调
 */
- (AFHTTPRequestOperation *_Nonnull)downloadFileWithOption:(NSDictionary *_Nullable)paramDic
                 withInferface:(NSString*_Nonnull)requestURL
                     savedPath:(NSString*_Nonnull)savedPath
               downloadSuccess:(void (^_Nullable)(AFHTTPRequestOperation  *_Nullable operation, id _Nullable responseObject))success
               downloadFailure:(void (^_Nullable)(AFHTTPRequestOperation *_Nullable operation, NSError *_Nullable error))failure
                      progress:(void (^_Nullable)(float progress, float total))progress;


- (AFHTTPRequestOperation *_Nonnull)postUploadImage:(NSURL *_Nonnull)imageFileUrl
                                     userId:(long long)userId
                               withComplete:(void (^_Nonnull)(NSDictionary *_Nonnull result, BOOL success, NSError *_Nullable error))block;

@end
