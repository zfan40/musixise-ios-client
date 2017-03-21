//
//  MYUploadUtils.m
//  musixise
//
//  Created by wmy on 2017/3/14.
//  Copyright © 2017年 wmy. All rights reserved.
//

#import "MYUploadUtils.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import <MYNetwork/MYBaseNetWorkUtil.h>
#import <MYUtils/MYFileUtil.h>

#define Hx_Main_heard_API  @"http://api.musixise.com/api"
#define IMAGE_UPLOAD_URL_API @"/picture/uploadPic"

@implementation MYUploadUtils

/**
 上传图片
 
 @param image 图片数据
 @param block 完成的block
 */
- (void)uploadImage:(UIImage *)image
       withComplete:(void (^)(NSString *imageUrl))block {
    
    //1. 存放图片的服务器地址，这里我用的宏定义
    NSString * url = [NSString stringWithFormat:@"%@%@",Hx_Main_heard_API,IMAGE_UPLOAD_URL_API];
    //2. 利用时间戳当做图片名字
    NSString *fileName = [self tmpFile];
    
    //3. 图片二进制文件
    NSData *imageData = UIImageJPEGRepresentation(image, .5f);
    //4. 发起网络请求
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestSerializer *request = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer = request;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 上传图片，以文件流的格式，这里注意：name是指服务器端的文件夹名字
        [formData appendPartWithFileData:imageData name:@"files" fileName:fileName mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //上传成功时的回调
        NSDictionary *obj = (NSDictionary *)responseObject;
        if (block) {
            block([obj objectForKey:@"data"]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //失败时的回调
        NSLog(@"123456%@",error);
        
    }];
}

- (NSString *)tmpFile {
    NSString *fileName = [NSString stringWithFormat:@"%lf+%d.jpg", [[NSDate date] timeIntervalSince1970], rand()];
    return fileName;
}

@end
