//
//  TTMutableDictionary+TTSafe.m
//  TTLiveHouse
//
//  Created by myc on 15/9/29.
//  Copyright © 2015年 Alibaba. All rights reserved.
//

#import "NSMutableDictionary+ALMSafe.h"

@implementation NSMutableDictionary(ALMSafe)

- (void)setObjectForMY:(id) object
               forKey:(id) key
{
    if ([key conformsToProtocol:@protocol(NSCopying)]) {
        if (object == nil) {
        }
        else {
            [self setObject:object forKey:key];
        }
    }else{
    }
}


@end
