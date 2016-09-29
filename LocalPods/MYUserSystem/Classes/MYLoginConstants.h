//
//  MYLoginConstants.h
//  musixise
//
//  Created by wmy on 16/9/28.
//  Copyright © 2016年 wmy. All rights reserved.
//

#ifndef MYLoginConstants_h
#define MYLoginConstants_h

typedef enum {
    MYLoginType_Normal = 0,
    MYLoginType_Weibo = 1,
    MYLoginType_Weixin = 2,
    MYLoginType_QQ = 3,
    MYLoginType_Taobao = 4,
} MYLoginType;

#define kWeiboAddressRedictURI @"http://www.musixise.com/"
#define kWeiboAppKey @"1564995937"
#define kWeiboAppSecret @"64e42bd75707b9b6ac719db7961228e0"



#endif /* MYLoginConstants_h */
