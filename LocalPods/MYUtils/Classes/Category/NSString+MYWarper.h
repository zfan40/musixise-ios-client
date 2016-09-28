//
//  NSString+MYWarper.h
//  xiaplay
//
//  Created by wmy on 15/11/26.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MYWarper)

- (int) compareTo:(NSString*) anotherString;

- (int) compareToIgnoreCase:(NSString*) str;

- (BOOL) contains:(NSString*) str;

- (BOOL) startsWith:(NSString*)prefix;

- (BOOL) endsWith:(NSString*)suffix;

- (BOOL) equals:(NSString*) anotherString;

- (BOOL) equalsIgnoreCase:(NSString*) anotherString;

- (int) indexOfChar:(unichar)ch;

- (int) indexOfChar:(unichar)ch fromIndex:(int)index;

- (int) indexOfString:(NSString*)str;

- (int) indexOfString:(NSString*)str fromIndex:(int)index;

- (int) lastIndexOfChar:(unichar)ch;

- (int) lastIndexOfChar:(unichar)ch fromIndex:(int)index;

- (int) lastIndexOfString:(NSString*)str;

- (int) lastIndexOfString:(NSString*)str fromIndex:(int)index;

- (NSString *) substringFromIndex:(int)beginIndex toIndex:(int)endIndex;

- (NSString *) toLowerCase;

- (NSString *) toUpperCase;

- (NSString *) trim;

- (NSString *) replaceAll:(NSString*)origin with:(NSString*)replacement;

- (NSArray *) split:(NSString*) separator;

@end
