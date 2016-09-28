//
//  UIImage+MYImage.h
//  sinaWeiBo
//
//  Created by 温明妍 on 15/10/15.
//  Copyright (c) 2015年 wmy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MYImage)
/**
 *  加载最原始的图片
 *
 *  @param image imageStr
 *
 *  @return UIImage
 */
+ (instancetype)imageNamedWithOrignal:(NSString *)image;

+ (instancetype)createImageWithColor:(UIColor *)color;

+ (instancetype)createImageWithColor:(UIColor *)color size:(CGSize)size;

- (instancetype)imageWithColor:(UIColor *)color;

@end
