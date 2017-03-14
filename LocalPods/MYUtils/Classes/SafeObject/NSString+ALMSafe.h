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
- (unichar)characterAtIndexForMY:(NSUInteger)index;
- (void)getCharactersForMY:(unichar *)buffer range:(NSRange)aRange;
- (NSString *)substringFromIndexForMY:(NSUInteger)from;
- (NSString *)substringToIndexForMY:(NSUInteger)to;
- (NSString *)substringWithRangeForMY:(NSRange)range;
- (NSString *)stringByAppendingStringForMY:(NSString *)aString;
- (NSString *)stringByReplacingOccurrencesOfStringForMY:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange NS_AVAILABLE(10_5, 2_0);
- (NSString *)stringByReplacingCharactersInRangeForMY:(NSRange)range withString:(NSString *)replacement NS_AVAILABLE(10_5, 2_0);
@end
