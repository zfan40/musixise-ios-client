//
//  NSString+ALMSafe.h
//  ALMLiveHouse
//
//  Created by myc on 15/9/28.
//  Copyright © 2015年 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ALMSafe)

+ (NSString *)boolStr:(BOOL) boolValue;
+ (NSString *)integerStr:(NSInteger) integer;
+ (NSString *)uIntegerStr:(NSUInteger) integer;
- (unichar)characterAtIndexForALM:(NSUInteger)index;
- (void)getCharactersForALM:(unichar *)buffer range:(NSRange)aRange;
- (NSString *)substringFromIndexForALM:(NSUInteger)from;
- (NSString *)substringToIndexForALM:(NSUInteger)to;
- (NSString *)substringWithRangeForALM:(NSRange)range;
- (NSString *)stringByAppendingStringForALM:(NSString *)aString;
- (NSString *)stringByReplacingOccurrencesOfStringForALM:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange NS_AVAILABLE(10_5, 2_0);
- (NSString *)stringByReplacingCharactersInRangeForALM:(NSRange)range withString:(NSString *)replacement NS_AVAILABLE(10_5, 2_0);
@end
