//
//  MYSystemLoginManager.h
//  Pods
//
//  Created by wmy on 2016/11/1.
//
//  系统的与登录相关的接口

#import <MYUtils/MYBasicSingleton.h>
#import "MYLoginConstants.h"

@interface MYSystemLoginManager : MYBasicSingleton

- (void)systemLoginWithName:(NSString *)title withPassword:(NSString *)password loginCallback:(LoginCallback)callback;

- (void)getUserInfo;

@end
