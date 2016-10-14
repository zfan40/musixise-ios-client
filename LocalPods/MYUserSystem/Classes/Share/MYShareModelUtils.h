//
//  MYShareModelUtils.h
//  Pods
//
//  Created by wmy on 16/10/10.
//
//

#import <Foundation/Foundation.h>
@class MYShareModel;

typedef enum {
    MYShareModelUtilsType_Weixin = 1,
    MYShareModelUtilsType_Weixin_Friends = 2,
    MYShareModelUtilsType_Weibo = 3,
    MYShareModelUtilsType_QQ = 4,
    MYShareModelUtilsType_Qzone = 5,
} MYShareModelType;

@interface MYShareModelUtils : NSObject

+ (MYShareModel *)modelWithType:(MYShareModelType)type;

@end
