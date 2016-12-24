//
//  MYWeiBoLoginManager.m
//  Pods
//
//  Created by wmy on 2016/11/1.
//
//

#import "MYWeiBoLoginManager.h"
#import <MYThirdKit/MYThirdWeiboLoginManager.h>

@implementation MYWeiBoLoginManager

- (void)weiboLoginWithCallback:(LoginCallback)callback {
    //TODO: wmy
    [[MYThirdWeiboLoginManager sharedInstance] loginWithCallback:^(BOOL success,NSError *error) {
        if (callback) {
            callback(success,error);
        }
    }];
}

@end
