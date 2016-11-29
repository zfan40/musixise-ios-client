//
//  MYMusixiseLoginManager.h
//  Pods
//
//  Created by wmy on 16/9/28.
//
// 废弃

#import <MYUtils/MYBasicSingleton.h>
#import "MYLoginConstants.h"

@class MYWeiBoResponseModel;

typedef void(^RequestCallback)(NSDictionary *dict,NSError *error);

@interface MYMusixiseLoginManager : MYBasicSingleton NS_DEPRECATED_IOS(2_0, 6_0);

- (void)musixiseLoginWithType:(MYLoginType)loginType withModel:(MYWeiBoResponseModel *)model withCallback:(RequestCallback)callback;

@end
