//
//  MYBaicSingleton.h
//  xiaplay
//
//  Created by wmy on 15/11/25.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYBasicSingleton : NSObject
+ (instancetype) shared;

+ (instancetype)sharedInstance;
+ (void)releasesharedInstance;
@end
