//
//  TTUtilHelper.m
//  treeBank
//
//  Created by kebi on 16/6/1.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTUtilHelper.h"

@implementation TTUtilHelper
+(NSString*)traceNo:(NSString*)objId{
    NSTimeInterval curDate = [[NSDate date]timeIntervalSince1970]*1000;
    NSString *traceNo = [NSString stringWithFormat:@"%@%f", objId,curDate];
    return traceNo;
}

@end
