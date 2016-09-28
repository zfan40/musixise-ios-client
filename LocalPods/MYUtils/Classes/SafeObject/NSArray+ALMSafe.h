//
//  TTArray+TTSafe.h
//  TTLiveHouse
//
//  Created by myc on 15/9/28.
//  Copyright © 2015年 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (ALMSafe)

+ (id)arrayWithObjectForALM:(id)anObject;
- (id)objectAtIndexForALM:(NSUInteger)index;
- (NSArray *)arrayByAddingObjectForALM:(id)anObject;
- (NSArray *)subarrayWithRangeForALM:(NSRange)range;
- (void)getObjectsForALM:(id __unsafe_unretained [])objects range:(NSRange)range;
- (NSArray *)objectsAtIndexesForALM:(NSIndexSet *)indexes;
+ (NSArray *)arrayWithArrayForALM:(NSArray *) array;
@end
