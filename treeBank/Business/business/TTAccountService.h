//
//  TTAccountService.h
//  treeBank
//
//  Created by kebi on 16/4/23.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTRunTime.h"

@interface TTAccountService : NSObject

+(instancetype)shareInstance;

-(void)accountMember:(NSString*)token  objId:(NSString*)objId block:(void(^)(id result ,BOOL ret,NSError *error))block;

-(void)autoLogin;
@end
