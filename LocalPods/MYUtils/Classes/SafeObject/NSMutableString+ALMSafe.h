//
//  NSMutableString+ALMSafe.h
//  ALMLiveHouse
//
//  Created by myc on 15/9/28.
//  Copyright © 2015年 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableString (ALMSafe)

- (void)replaceCharactersInRangeForALM:(NSRange)range withString:(NSString *)aString;
- (void)insertStringForALM:(NSString *)aString atIndex:(NSUInteger)loc;
- (void)deleteCharactersInRangeForALM:(NSRange)range;
- (void)appendStringForALM:(NSString *)aString;
- (void)setStringForALM:(NSString *)aString;
- (NSUInteger)replaceOccurrencesOfStringForALM:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange;

@end
