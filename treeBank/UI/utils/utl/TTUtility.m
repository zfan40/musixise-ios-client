//
//  ALMUtility.m
//  Pods
//
//  Created by wmy on 15/11/23.
//
//

#import "TTUtility.h"

BOOL isNullForALM(id value) {
    return (!value || [value isKindOfClass:[NSNull class]]);
}
int toInt(id value) {
    return (isNullForALM(value) ? 0 : [value intValue]);
}
BOOL isEmptyString(id value) {
    return (isNullForALM(value) || [value isEqual:@""] || [value isEqual:@"(null)"]);
}
NSTimeInterval tNow() {
    return [[NSDate date] timeIntervalSince1970];
}
NSString *str(NSString *fmt, ...) {
    va_list valist;
    va_start(valist, fmt);
    NSString *s = [[NSString alloc] initWithFormat:fmt arguments:valist];
    va_end(valist);
    return s;
}
