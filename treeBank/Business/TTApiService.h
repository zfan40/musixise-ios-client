//
//  TTApiService.h
//  treeBank
//
//  Created by kebi on 16/4/17.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTApiService : NSObject
+ (instancetype)instance;
- (void)getRequest:(NSString *)method
         parameter:(NSDictionary *)dics
             block:(void (^)(id result, BOOL ret, NSError *error))block;

//(@"http://shugen.9158k.com/")
- (void)postRequest:(NSString *)method
          parameter:(NSDictionary *)dics
              block:(void (^)(id result, BOOL ret, NSError *error))block;
- (void)postImageRequest:(NSString *)method
               parameter:(NSDictionary *)dics
               imageDics:(NSDictionary *)imageDics
                   block:(void (^)(id result, BOOL ret, NSError *error))block;

//(@"http://183.134.101.35/")
- (void)payPostRequest:(NSString *)method
             parameter:(NSDictionary *)dics
                 block:(void (^)(id result, BOOL ret, NSError *error))block;

- (void)payPostImageRequest:(NSString *)method
                  parameter:(NSDictionary *)dics
                  imageDics:(NSDictionary *)imageDics
                      block:(void (^)(id result, BOOL ret, NSError *error))block;

@end

#define theApiService ([TTApiService instance])