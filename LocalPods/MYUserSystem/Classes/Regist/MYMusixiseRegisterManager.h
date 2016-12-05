//
//  MYMusixiseRegistManager.h
//  Pods
//
//  Created by wmy on 2016/12/4.
//
//  注册接口，所有与注册相关的业务入口

#import <MYUtils/MYBasicSingleton.h>

typedef void(^RegistCallback)(BOOL success,NSError *error);

@class MYRegistModel;

@interface MYMusixiseRegisterManager : MYBasicSingleton

- (void)registerWithModel:(MYRegistModel *)model callback:(RegistCallback)callback;

@end
