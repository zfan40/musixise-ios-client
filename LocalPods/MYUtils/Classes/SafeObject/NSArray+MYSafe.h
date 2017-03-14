//
//  TTArray+TTSafe.h
//  TTLiveHouse
//
//  Created by myc on 15/9/28.
//  Copyright © 2015年 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (MYSafe)

+ (id)arrayWithObjectForMY:(id)anObject;
- (id)objectAtIndexForMY:(NSUInteger)index;
- (NSArray *)arrayByAddingObjectForMY:(id)anObject;
- (NSArray *)subarrayWithRangeForMY:(NSRange)range;
- (void)getObjectsForMY:(id __unsafe_unretained [])objects range:(NSRange)range;
- (NSArray *)objectsAtIndexesForMY:(NSIndexSet *)indexes;
+ (NSArray *)arrayWithArrayForMY:(NSArray *) array;
@end
