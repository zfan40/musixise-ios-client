//
//  NSMutableArray+ALMSafe.h
//  ALMLiveHouse
//
//  Created by myc on 15/9/28.
//  Copyright © 2015年 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (ALMSafe)

- (void)addObjectForALM:(id)anObject;
- (void)insertObjectForALM:(id)anObject atIndex:(NSUInteger)index;
- (void)removeObjectAtIndexForALM:(NSUInteger)index;
- (void)replaceObjectAtIndexForALM:(NSUInteger)index withObject:(id)anObject;
- (void)exchangeObjectAtIndexForALM:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2;
- (void)removeObjectForALM:(id)anObject inRange:(NSRange)range;
- (void)removeObjectIdenticalToForALM:(id)anObject inRange:(NSRange)range;
- (void)removeObjectsInRangeForALM:(NSRange)range;
- (void)replaceObjectsInRangeForALM:(NSRange)range withObjectsFromArray:(NSArray *)otherArray;
- (void)replaceObjectsInRangeForALM:(NSRange)range withObjectsFromArray:(NSArray *)otherArray range:(NSRange)otherRange;
- (void)insertObjectsForALM:(NSArray *)objects atIndexes:(NSIndexSet *)indexes;
- (void)removeObjectsAtIndexesForALM:(NSIndexSet *)indexes;
- (void)replaceObjectsAtIndexesForALM:(NSIndexSet *)indexes withObjects:(NSArray *)objects;
@end
