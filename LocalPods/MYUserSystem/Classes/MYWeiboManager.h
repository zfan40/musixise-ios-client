//
//  MYWeiboManager.h
//  Pods
//
//  Created by wmy on 16/10/16.
//
//

#import <MYUtils/MYBasicSingleton.h>
#import <WeiboSDK/WeiboSDK.h>
@class MYBaseWeiBoShareModel;

@interface MYWeiboManager : MYBasicSingleton <WeiboSDKDelegate>

- (void)setup;

- (void)shareWithShareModel:(MYBaseWeiBoShareModel *)shareModel;

@end
