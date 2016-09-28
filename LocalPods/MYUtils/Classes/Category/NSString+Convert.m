//
//  NSString+Convert.m
//  Pods
//
//  Created by wmy on 16/6/12.
//
//

#import "NSString+Convert.h"

@implementation NSString (Convert)

- (unsigned long)stringToHex {
    return strtoul([self UTF8String], 0, 16);
}


@end
