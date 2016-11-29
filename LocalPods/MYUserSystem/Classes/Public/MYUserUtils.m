//
//  MYUserUtils.m
//  Pods
//
//  Created by wmy on 16/9/28.
//
//

#import "MYUserUtils.h"
#import "MYUser.h"

@interface MYUserUtils ()

@property(nonatomic, strong) MYUser *user;

@end

@implementation MYUserUtils

- (void)updateUser:(MYUser *)user {
    //TODO: wmy 登录或者修改用户信息后需要调用更新用户信息的接口
}

- (NSString *)userName {
    return self.user.userName;
}

- (long long)userId {
    return self.user.userId;
}

@end
