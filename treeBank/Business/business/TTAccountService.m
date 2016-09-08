//
//  TTAccountService.m
//  treeBank
//
//  Created by kebi on 16/4/23.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTAccountService.h"
#import "TTApiService.h"
#import "TTIntroductionView.h"
#import "TTTipsHelper.h"

@implementation TTAccountService
+ (instancetype)shareInstance {
    static TTAccountService *instance = nil;
    if (!instance) {
        instance = [TTAccountService new];
    }
    return instance;
}

- (id)init {
    self = [super init];
    return self;
}

- (void)accountMember:(NSString *)token
                objId:(NSString *)objId
                block:(void (^)(id result, BOOL ret, NSError *error))block {

    [theApiService
        postRequest:@"/account/index.htm"
          parameter:@{
              @"token": token,
              @"memberid": objId ? objId : @""
          }
              block:^(id result, BOOL ret, NSError *error) {
                  BOOL state = [[result objectForKey:@"success"] boolValue];
                  if (state) {
                      TTUser *user = [TTUser new];
                      user.token = token;
                      user.objId = objId;
                      [user parseData:result];
                      [TTRunTime instance].user = user;
                      [[NSNotificationCenter defaultCenter] postNotificationName:kTTUserChangedNotification object:nil];
                      [TTIntroductionView showIntroductionView];
                  } else {
                      [TTTipsHelper showTip:@"登录失败"];
                  }
                  block(result, YES, nil);
              }];
}

- (void)autoLogin {
}

@end
