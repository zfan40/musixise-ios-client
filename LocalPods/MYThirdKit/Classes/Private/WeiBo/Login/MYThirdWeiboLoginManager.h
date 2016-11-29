//
//  MYLoginManager.h
//  musixise
//
//  Created by wmy on 16/9/28.
//  Copyright © 2016年 wmy. All rights reserved.
//

#import <MYUtils/MYBasicSingleton.h>
#import "MYLoginConstants.h"


@interface MYThirdWeiboLoginManager : MYBasicSingleton

- (void)loginWithCallback:(LoginCallback)callback;
- (BOOL)handleWithURL:(NSString *)url;

@end
