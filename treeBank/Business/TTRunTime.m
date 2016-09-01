//
//  TTRunTime.m
//  treeBank
//
//  Created by kebi on 16/4/17.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTRunTime.h"
#import <AFNetworking/AFNetworkReachabilityManager.h>


@implementation TTRunTime


+(instancetype)instance{
    static TTRunTime *instance = nil;
    if(!instance){
        instance = [TTRunTime new];
    }
    return instance;
}

-(TTNetworkStatus)netWorkStatus{
    _netWorkStatus = (TTNetworkStatus)[ AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
    return _netWorkStatus;
}



@end
