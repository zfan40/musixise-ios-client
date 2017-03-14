//
//  NSMutableString+ALMSafe.h
//  ALMLiveHouse
//
//  Created by myc on 15/9/28.
//  Copyright © 2015年 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableString (ALMSafe)

- (void)replaceCharactersInRangeForMY:(NSRange)range withString:(NSString *)aString;
- (void)insertStringForMY:(NSString *)aString atIndex:(NSUInteger)loc;
- (void)deleteCharactersInRangeForMY:(NSRange)range;
- (void)appendStringForMY:(NSString *)aString;
- (void)setStringForMY:(NSString *)aString;
- (NSUInteger)replaceOccurrencesOfStringForMY:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange;

@end
