//
//  TTRunTime.h
//  treeBank
//
//  Created by kebi on 16/4/17.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTUser.h"

#define kTTUserChangedNotification @"kTTUserChangedNotification"

typedef NS_ENUM( NSInteger, TTNetworkStatus) {
    TTNetworkStatus_Unknown = -1,
    TTNetworkStatus_NotReachable,
    TTNetworkStatus_Wan,
    TTNetworkStatus_Wifi
};


@interface TTRunTime : NSObject
+(instancetype)instance;
@property (nonatomic, assign )TTNetworkStatus  netWorkStatus;
@property (nonatomic, strong)TTUser *user;
@end
