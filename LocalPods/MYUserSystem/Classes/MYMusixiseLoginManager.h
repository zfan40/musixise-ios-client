//
//  MYMusixiseLoginManager.h
//  Pods
//
//  Created by wmy on 16/9/28.
//
//

#import <MYUtils/MYBasicSingleton.h>
#import "MYLoginConstants.h"

@class MYWeiBoResponseModel;

typedef void(^RequestCallback)(NSDictionary *dict,NSError *error);

@interface MYMusixiseLoginManager : MYBasicSingleton

- (void)musixiseLoginWithType:(MYLoginType)loginType withModel:(MYWeiBoResponseModel *)model withCallback:(RequestCallback)callback;

@end
