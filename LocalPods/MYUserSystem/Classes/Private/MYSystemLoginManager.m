//
//  MYSystemLoginManager.m
//  Pods
//
//  Created by wmy on 2016/11/1.
//
//

#import "MYSystemLoginManager.h"
#import <MYUtils/MYSafeUtil.h>

@implementation MYSystemLoginManager

- (void)systemLoginWithName:(NSString *)title withPassword:(NSString *)password loginCallback:(LoginCallback)callback {
    if (isEmptyString(title) || isEmptyString(password)) {
        if (callback) {
            callback(NO);
        }
    } else {
        //TODO: wmy 访问系统的登录
    }
}

@end
