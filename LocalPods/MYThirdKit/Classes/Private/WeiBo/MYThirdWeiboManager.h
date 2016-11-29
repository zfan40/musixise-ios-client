//
//  MYWeiboManager.h
//  Pods
//
//  Created by wmy on 16/10/16.
//
//

#import <MYUtils/MYBasicSingleton.h>
#import "MYShareModelProtocol.h"
#import "MYThirdConstants.h"

@class MYBaseWeiBoShareModel;

@interface MYThirdWeiboManager : MYBasicSingleton

- (void)setup;

- (void)shareWithShareModel:(id<MYShareModelProtocol>)shareModel;

- (BOOL)handleUrl:(NSURL *)url;

- (void)loginWithCallback:(LoginCallback)callback;

@end
