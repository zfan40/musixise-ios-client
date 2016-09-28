//
//  NSMutableString+ALMSafe.m
//  ALMLiveHouse
//
//  Created by myc on 15/9/28.
//  Copyright © 2015年 Alibaba. All rights reserved.
//

#import "NSMutableString+ALMSafe.h"

@implementation NSMutableString (ALMSafe)

- (void)replaceCharactersInRangeForALM:(NSRange)range withString:(NSString *)aString
{
    if (nil != aString && range.location+range.length <= self.length) {
        [self replaceCharactersInRange:range withString:aString];
    }
    else
    {
    }
}

- (void)insertStringForALM:(NSString *)aString atIndex:(NSUInteger)loc
{
    if (nil != aString && loc <= self.length) {
        [self insertString:aString atIndex:loc];
    }
    else
    {
    }
}

- (void)deleteCharactersInRangeForALM:(NSRange)range
{
    if (range.location + range.length <= self.length) {
        [self deleteCharactersInRange:range];
    }
    else
    {
    }
}

- (void)appendStringForALM:(NSString *)aString
{
    if (nil != aString) {
        [self appendString:aString];
    }
    else
    {
    }
}

- (void)setStringForALM:(NSString *)aString
{
    if (nil != aString) {
        [self setString:aString];
    }
    else
    {
    }
}

- (NSUInteger)replaceOccurrencesOfStringForALM:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange
{
    if (nil != target && nil != replacement && searchRange.location + searchRange.length <= self.length) {
        return [self replaceOccurrencesOfString:target withString:replacement options:options range:searchRange];
    }
    else
    {
        return 0;
    }
}
@end

