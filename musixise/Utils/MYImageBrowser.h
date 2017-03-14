//
//  MYImageBrowser.h
//  musixise
//
//  Created by wmy on 2017/3/14.
//  Copyright © 2017年 wmy. All rights reserved.
//

#import <MYUtils/MYBasicSingleton.h>
#import <UIKit/UIKit.h>

@class MYBaseViewController;

typedef void(^ImageBrowserBlock)(NSString *imageUrl, BOOL success);

@interface MYImageBrowser : MYBasicSingleton

- (void)imageBrowserWithBlock:(ImageBrowserBlock)block;
- (void)imageBrowserWithBlock:(ImageBrowserBlock)block rootVC:(UIViewController *)vc;

@end
