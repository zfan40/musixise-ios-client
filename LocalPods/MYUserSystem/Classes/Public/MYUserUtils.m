//
//  MYUserUtils.m
//  Pods
//
//  Created by wmy on 16/9/28.
//
//

#import "MYUserUtils.h"

@implementation MYUserUtils

- (void)updateUser:(MYUser *)user {
    //TODO: wmy 登录或者修改用户信息后需要调用更新用户信息的接口
    self.user = user;
}

- (NSString *)userName {
    return self.user.username;
}

- (long long)userId {
    return self.user.userId;
}

@end
