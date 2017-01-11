//
//  MYUser.h
//  Pods
//
//  Created by wmy on 2016/11/1.
//
//

#import <MYMVVM/MYBaseViewModel.h>
#import "MYUserModel.h"

typedef enum {
    MYUserGenderTypeUnKnown = 0,
    MYUserGenderTypeFemale = 1,
    MYUserGenderTypeMale = 2,
} MYUserGenderType;

@interface MYUser : MYBaseViewModel

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

@property(nonatomic, assign) MYUserGenderType genderType;

- (NSDictionary *)dictWithProperty;

@end
