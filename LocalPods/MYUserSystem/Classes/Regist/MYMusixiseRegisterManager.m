//
//  MYMusixiseRegistManager.m
//  Pods
//
//  Created by wmy on 2016/12/4.
//
//

#import "MYMusixiseRegisterManager.h"
#import <MYNetwork/MYBaseNetWorkUtil.h>
#import "MYRegistModel.h"

@implementation MYMusixiseRegisterManager

- (void)registerWithModel:(MYRegistModel *)model callback:(RegistCallback)callback {
    //TODO: wmy 访问网络
    NSString *requestMethod = @"user/register";
    NSMutableDictionary *dict = [model modelDictionary];
    
    [[MYBaseNetWorkUtil sharedInstance] posthttpWithDictionary:dict
                                                    withMethod:requestMethod
                                                  withComplete:^(NSDictionary * _Nonnull result, BOOL success, NSError * _Nullable error) {
//                                                      DebugLog(@"");
                                                      if (callback) {
                                                          callback(success,error);
                                                      }
                                                  }];
    
}

@end
