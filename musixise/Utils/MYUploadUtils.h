//
//  MYUploadUtils.h
//  musixise
//
//  Created by wmy on 2017/3/14.
//  Copyright © 2017年 wmy. All rights reserved.
//

#import <MYUtils/MYBasicSingleton.h>
#import <UIKit/UIKit.h>

@interface MYUploadUtils : MYBasicSingleton

/**
 上传图片
 
 @param image 图片数据
 @param block 完成的block
 */
- (void)uploadImage:(UIImage *)image
       withComplete:(void (^)(NSString *imageUrl))block;

@end
