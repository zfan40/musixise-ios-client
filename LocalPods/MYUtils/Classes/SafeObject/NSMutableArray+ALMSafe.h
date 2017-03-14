//
//  NSMutableArray+ALMSafe.h
//  ALMLiveHouse
//
//  Created by myc on 15/9/28.
//  Copyright © 2015年 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (ALMSafe)

- (void)addObjectForMY:(id)anObject;
- (void)insertObjectForMY:(id)anObject atIndex:(NSUInteger)index;
- (void)removeObjectAtIndexForMY:(NSUInteger)index;
- (void)replaceObjectAtIndexForMY:(NSUInteger)index withObject:(id)anObject;
- (void)exchangeObjectAtIndexForMY:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2;
- (void)removeObjectForMY:(id)anObject inRange:(NSRange)range;
- (void)removeObjectIdenticalToForMY:(id)anObject inRange:(NSRange)range;
- (void)removeObjectsInRangeForMY:(NSRange)range;
- (void)replaceObjectsInRangeForMY:(NSRange)range withObjectsFromArray:(NSArray *)otherArray;
- (void)replaceObjectsInRangeForMY:(NSRange)range withObjectsFromArray:(NSArray *)otherArray range:(NSRange)otherRange;
- (void)insertObjectsForMY:(NSArray *)objects atIndexes:(NSIndexSet *)indexes;
- (void)removeObjectsAtIndexesForMY:(NSIndexSet *)indexes;
- (void)replaceObjectsAtIndexesForMY:(NSIndexSet *)indexes withObjects:(NSArray *)objects;
@end
