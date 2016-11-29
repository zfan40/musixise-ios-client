//
//  MYWeiBoLoginManager.h
//  Pods
//
//  Created by wmy on 2016/11/1.
//
//

#import <MYUtils/MYBasicSingleton.h>
#import "MYLoginConstants.h"

@interface MYWeiBoLoginManager : MYBasicSingleton

- (void)weiboLoginWithCallback:(LoginCallback)callback;

@end
