//
//  TTApiService.m
//  treeBank
//
//  Created by kebi on 16/4/17.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTApiService.h"
#import "TTTipsHelper.h"
#import <AFNetworking/AFHTTPSessionManager.h>

#define KApi (@"http://shugen.9158k.com/")
#define kPayApi (@"http://183.134.101.35/")

@implementation TTApiService {
    AFHTTPSessionManager *_sessionManager;
    AFHTTPSessionManager *_sessionPayManager;
}

+ (instancetype)instance {
    static TTApiService *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [TTApiService new];
    });
    return instance;
}

- (id)init {
    self = [super init];
    _sessionManager =
        [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:KApi] sessionConfiguration:nil];
    _sessionPayManager =
        [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kPayApi] sessionConfiguration:nil];
    _sessionPayManager.responseSerializer = [AFHTTPResponseSerializer serializer];

    return self;
}

- (void)postRequest:(NSString *)method
          parameter:(NSDictionary *)dics
              block:(void (^)(id result, BOOL ret, NSError *error))block {

    [_sessionManager POST:method
        parameters:dics
        progress:^(NSProgress *_Nonnull uploadProgress) {

        }
        success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
            block(responseObject, YES, nil);
        }
        failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
            block(nil, NO, error);
        }];
}

- (void)getRequest:(NSString *)method
         parameter:(NSDictionary *)dics
             block:(void (^)(id result, BOOL ret, NSError *error))block {
    [_sessionManager POST:method
        parameters:dics
        progress:^(NSProgress *_Nonnull downloadProgress) {

        }
        success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
            block(responseObject, YES, nil);
        }
        failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
            block(nil, NO, error);
        }];
}

- (void)postImageRequest:(NSString *)method
               parameter:(NSDictionary *)dics
               imageDics:(NSDictionary *)imageDics
                   block:(void (^)(id result, BOOL ret, NSError *error))block {
    [_sessionManager POST:method
        parameters:dics
        constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            for (NSString *key in [imageDics allKeys]) {
                UIImage *image = [imageDics objectForKey:key];
                NSData *data = UIImageJPEGRepresentation(image, 1.0f);
                NSString *fileName = [NSString stringWithFormat:@"%@_%@.jpeg", str, key];
                [formData appendPartWithFileData:data name:key fileName:fileName mimeType:@"image/jpeg"];
            }

        }
        progress:^(NSProgress *_Nonnull uploadProgress) {

        }
        success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
            block(responseObject, YES, nil);
        }
        failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
            block(nil, NO, error);
        }];
}

- (void)payPostRequest:(NSString *)method
             parameter:(NSDictionary *)dics
                 block:(void (^)(id result, BOOL ret, NSError *error))block {
    [_sessionPayManager POST:method
        parameters:dics
        progress:^(NSProgress *_Nonnull uploadProgress) {

        }
        success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
            NSDictionary *ret = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                options:NSJSONReadingMutableContainers
                                                                  error:nil];
            block(ret, YES, nil);
        }
        failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
            block(nil, NO, error);
        }];
}

- (void)payPostImageRequest:(NSString *)method
                  parameter:(NSDictionary *)dics
                  imageDics:(NSDictionary *)imageDics
                      block:(void (^)(id result, BOOL ret, NSError *error))block {
    [_sessionPayManager POST:method
        parameters:dics
        constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            for (NSString *key in [imageDics allKeys]) {
                UIImage *image = [imageDics objectForKey:key];
                NSData *data = UIImageJPEGRepresentation(image, 1.0f);
                NSString *fileName = [NSString stringWithFormat:@"%@_%@.jpeg", str, key];
                [formData appendPartWithFileData:data name:key fileName:fileName mimeType:@"image/jpeg"];
            }

        }
        progress:^(NSProgress *_Nonnull uploadProgress) {

        }
        success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
            NSDictionary *ret = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                options:NSJSONReadingMutableContainers
                                                                  error:nil];
            block(ret, YES, nil);
        }
        failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
            block(nil, NO, error);
        }];
}

@end
