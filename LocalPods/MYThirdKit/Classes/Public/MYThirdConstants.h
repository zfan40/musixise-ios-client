//
//  MYThirdConstants.h
//  Pods
//
//  Created by wmy on 16/10/16.
//
//

#ifndef MYThirdConstants_h
#define MYThirdConstants_h

typedef enum {
    MYThirdKitType_Weibo = 1,
    MYThirdKitType_QQ = 2,
    MYThirdKitType_Weichat = 3,
} MYThirdKitType;

typedef void(^LoginCallback)(BOOL success,NSError *error);

#define kWeiboAddressRedictURI @"http://www.musixise.com/"
#define kWeiboAppKey @"1564995937"
#define kWeiboAppSecret @"64e42bd75707b9b6ac719db7961228e0"

#endif /* MYThirdConstants_h */
