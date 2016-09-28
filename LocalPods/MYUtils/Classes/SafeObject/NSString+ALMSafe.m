//
//  NSString+ALMSafe.m
//  ALMLiveHouse
//
//  Created by myc on 15/9/28.
//  Copyright © 2015年 Alibaba. All rights reserved.
//

#import "NSString+ALMSafe.h"

@implementation NSString (ALMSafe)


+ (NSString *)boolStr:(BOOL) boolValue
{
    return [NSString stringWithFormat:@"%d",boolValue];
}

+ (NSString *)integerStr:(NSInteger) integer
{
#if __LP64__ || (TARGET_OS_EMBEDDED && !TARGET_OS_IPHONE) || TARGET_OS_WIN32 || NS_BUILD_32_LIKE_64
    return [NSString stringWithFormat:@"%ld",(long)integer];
#else
    return [NSString stringWithFormat:@"%d",(int)integer];
#endif
}

+ (NSString *)uIntegerStr:(NSUInteger) uInteger
{
#if __LP64__ || (TARGET_OS_EMBEDDED && !TARGET_OS_IPHONE) || TARGET_OS_WIN32 || NS_BUILD_32_LIKE_64
    return [NSString stringWithFormat:@"%lu",(unsigned long)uInteger];
#else
    return [NSString stringWithFormat:@"%u",(unsigned int)uInteger];
#endif
}

- (unichar)characterAtIndexForALM:(NSUInteger)index
{
    if (index < self.length) {
        return [self characterAtIndex:index];
    }
    else
    {
        return (unichar)-1;
    }
}
- (void)getCharactersForALM:(unichar *)buffer range:(NSRange)aRange
{
    if (aRange.location+aRange.length <= self.length) {
        [self getCharacters:buffer range:aRange];
    }
    else
    {
    }
}
- (NSString *)substringFromIndexForALM:(NSUInteger)from
{
    if (from <= self.length) {
        return [self substringFromIndex:from];
    }
    else
    {
        return nil;
    }
}
- (NSString *)substringToIndexForALM:(NSUInteger)to
{
    if (to <= self.length) {
        return [self substringToIndex:to];
    }
    else
    {
        return nil;
    }
}
- (NSString *)substringWithRangeForALM:(NSRange)range
{
    if (range.location+range.length <= self.length) {
        return [self substringWithRange:range];
    }
    else
    {
        return nil;
    }
}

- (NSString *)stringByAppendingStringForALM:(NSString *)aString
{
    if (nil != aString) {
        return [self stringByAppendingString:aString];
    }
    else
    {
        return nil;
    }
}

- (NSString *)stringByAppendingPathExtensionForALM:(NSString *)str
{
    if (nil != str) {
        return [self stringByAppendingPathExtension:str];
    }
    else
    {
        return nil;
    }
}

- (NSString *)stringByPaddingToLengthForIndexForALM:(NSUInteger)newLength withString:(NSString *)XdString startingAtIndex:(NSUInteger)XdIndex
{
    if (XdIndex == 0 && nil != XdString && ![XdString isEqualToString:@""]) {
        return [self stringByPaddingToLength:newLength withString:XdString startingAtIndex:XdIndex];
    }
    else
    {
        return nil;
    }
}
- (NSString *)stringByReplacingOccurrencesOfStringForALM:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange
{
    if (searchRange.location + searchRange.length <= self.length) {
        return [self stringByReplacingOccurrencesOfString:target withString:replacement options:options range:searchRange];
    }
    else
    {
        return nil;
    }
}

- (NSString *)stringByReplacingCharactersInRangeForALM:(NSRange)range withString:(NSString *)replacement
{
    if (range.location + range.length <= self.length) {
        return [self stringByReplacingCharactersInRange:range withString:replacement];
    }
    else
    {
        return nil;
    }
}

@end

