//
//  NSDateFormatter+instance.m
//  xiamiBusiness
//
//  Created by 彭 玉堂 on 15-2-5.
//  Copyright (c) 2015年 xiami. All rights reserved.
//

#import "NSDateFormatter+instance.h"

@implementation NSDateFormatter (instance)

+ (NSDateFormatter *)dateFormatterForType:(NSString *)format {
    static NSMutableDictionary *formatMaps = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatMaps = [[NSMutableDictionary alloc] init];
    });
    NSDateFormatter *formatter = [formatMaps valueForKey:format];
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:format];
        [formatMaps setValue:formatter forKey:format];
    }
    return formatter;
}

@end
