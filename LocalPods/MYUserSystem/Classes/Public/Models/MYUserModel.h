//
//  MYUserModel.h
//  Pods
//
//  Created by wmy on 2016/12/24.
//
//

#import <MYMVVM/MYBaseModel.h>

@interface MYUserModel : MYBaseModel

@property (strong, nonatomic) NSString *username;
@property (assign, nonatomic) long long userId;
@property(nonatomic, strong) NSString *idToken;
@property(nonatomic, strong) NSString *birth;
@property(nonatomic, strong) NSString *email;

@property(nonatomic, strong) NSString *gender;
@property(nonatomic, assign) BOOL isMaster;
@property(nonatomic, strong) NSString *largeAvatar;
@property(nonatomic, strong) NSString *smallAvatar;
@property(nonatomic, strong) NSString *nation;
@property(nonatomic, strong) NSString *realname;
@property(nonatomic, strong) NSString *tel;

@end
