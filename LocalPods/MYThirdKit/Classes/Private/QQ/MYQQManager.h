//
//  MYQQManager.h
//  Pods
//
//  Created by wmy on 2016/10/28.
//
//

#import <MYUtils/MYBasicSingleton.h>

@class MYQQFriendModel;

@interface MYQQManager : MYBasicSingleton

- (void)setup;
- (void)shareQQFriendWithModel:(MYQQFriendModel *)model;


@end
