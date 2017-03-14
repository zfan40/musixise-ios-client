//
//  UIImageView+MYCache.m
//  xiaplay
//
//  Created by wmy on 15/11/25.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import "UIImageView+MYCache.h"
#import <MYUtils/UIView+MYAdditons.h>

@implementation UIImageView (MYCache)

- (void)my_setImageWithURL:(NSString *)urlString {
    self.contentMode = UIViewContentModeScaleAspectFill;
    self.clipsToBounds = YES;
    NSRange range = [urlString rangeOfString:@"@"];
    if (range.location != NSNotFound) {
        urlString = [urlString substringToIndex:range.location];
    }
//    urlString = [NSString stringWithFormat:@"%@@%.0fw_%.0fh.webp",urlString,self.width,self.height];
    //TODO: wmy
    // 自己来写代码吧，如果webp没有拿到图片，那么就用原url地址
    [self setImageWithURL:[NSURL URLWithString:urlString]];
    
}



//+ (ALMImageURI *)imageOSSUrlWithUrl:(NSString *)url config:(XImageConfig *)config {
//    ALMImageURI *imageURI = [ALMImageURI new];
//    imageURI.originUrl = url;
//    
//    if (!CGSizeEqualToSize(config.size, CGSizeZero)) {
//        imageURI.scale = ALMImageScale();
//        imageURI.size = config.size;
//    }
//    
//    if (!isSupportOSSUrlString(url) || (config.loadMode & ALMImageLoadModeOriginal)) {
//        imageURI.requestUrl = imageURI.originUrl;
//        return imageURI;
//    }
//    
//    NSString *originUrl = [XImageURLUtil getOriginURL:url];
//    NSString *scaleValue = [self ossScaleValueWithScale:imageURI.scale];
//    NSString *sizeValue = [self ossSizeValueWithSize:imageURI.size config:config];
//    NSString *cutValue = [self ossCutValueWithSize:imageURI.size config:config];
//    NSString *qualityValue = [self ossQualityValue];
//    NSString *sharpValue = [self ossSharpValue];
//    NSString *extentValue = [self ossExtentValue];
//    
//    imageURI.requestUrl = [originUrl stringByAppendingFormat:@"@%@%@%@%@%@%@", scaleValue, sizeValue, cutValue, qualityValue, sharpValue, extentValue];
//    imageURI.isOSSURL = YES;
//    
//    return imageURI;
//}

- (void)my_setImageWithURL:(NSString *)urlString placeholderImage:(UIImage *)defaultImage {
    [self setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:defaultImage];
}

- (void)my_setImageWithURL:(NSString *)urlString
                 completed:(void (^)(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished))completedBlock {
    [self setImageWithURL:[NSURL URLWithString:urlString] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if (completedBlock) {
            completedBlock(image,error,cacheType,YES);
        }
    }];
}

@end
