//
//  UIImageView+MYCache.h
//  xiaplay
//
//  Created by wmy on 15/11/25.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
//TODO: wmy 做进一步改进

@interface UIImageView (MYCache)

- (void)my_setImageWithURL:(NSString *)urlString;
- (void)my_setImageWithURL:(NSString *)urlString placeholderImage:(UIImage *)defaultImage;
- (void)my_setImageWithURL:(NSString *)urlString completed:(SDWebImageCompletionBlock)completedBlock;
@end
