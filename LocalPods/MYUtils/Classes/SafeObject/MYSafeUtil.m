//
//  MYSafeUtil.m
//  xiaplay
//
//  Created by wmy on 15/11/23.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import "MYSafeUtil.h"
BOOL isNullForMY(id value) {
    return (!value || [value isKindOfClass:[NSNull class]]);
}
BOOL isEmptyString(id value) {
    return (isNullForMY(value) || [value isEqual:@""] || [value isEqual:@"(null)"]);
}

NSTimeInterval tNow() {
    return [[NSDate date] timeIntervalSince1970];
}

@implementation MYSafeUtil



@end
