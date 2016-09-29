//
//  MYWeiBoResponseModel.h
//  Pods
//
//  Created by wmy on 16/9/28.
//
//

#import <Foundation/Foundation.h>

@interface MYWeiBoResponseModel : NSObject

@property (assign, nonatomic) long long userId;
@property (strong, nonatomic) NSString *accessToken;
@property (strong, nonatomic) NSString *refreshToken;
@property (strong, nonatomic) NSDate *expirationDate;

@end
