//
//  NSMutableArray+ALMSafe.m
//  ALMLiveHouse
//
//  Created by myc on 15/9/28.
//  Copyright © 2015年 Alibaba. All rights reserved.
//

#import "NSMutableArray+ALMSafe.h"

@implementation NSMutableArray (ALMSafe)

- (void)addObjectForMY:(id)anObject
{
    if (nil != anObject) {
        [self addObject:anObject];
    }
    else
    {
    }
}

- (void)insertObjectForMY:(id)anObject atIndex:(NSUInteger)index
{
    if (nil != anObject && index <= self.count) {
        [self insertObject:anObject atIndex:index];
    }
    else
    {
    }
}

- (void)removeObjectAtIndexForMY:(NSUInteger)index
{
    if (index < self.count) {
        [self removeObjectAtIndex:index];
    }
    else
    {
    }
}

- (void)replaceObjectAtIndexForMY:(NSUInteger)index withObject:(id)anObject
{
    if (nil != anObject && index < self.count) {
        [self replaceObjectAtIndex:index withObject:anObject];
    }
    else
    {
    }
}

- (void)exchangeObjectAtIndexForMY:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2
{
    if (idx1 < self.count && idx2 < self.count) {
        [self exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
    }
    else
    {
    }
}

- (void)removeObjectForMY:(id)anObject inRange:(NSRange)range
{
    if (range.location + range.length <= self.count) {
        [self removeObject:anObject inRange:range];
    }
    else
    {
    }
}

- (void)removeObjectIdenticalToForMY:(id)anObject inRange:(NSRange)range
{
    if (range.location + range.length <= self.count) {
        [self removeObjectIdenticalTo:anObject inRange:range];
    }
    else
    {
    }
}

- (void)removeObjectsInRangeForMY:(NSRange)range
{
    if (range.location + range.length <= self.count) {
        [self removeObjectsInRange:range];
    }
    else
    {
    }
}

- (void)replaceObjectsInRangeForMY:(NSRange)range withObjectsFromArray:(NSArray *)otherArray
{
    if (range.location + range.length <= self.count) {
        [self replaceObjectsInRange:range withObjectsFromArray:otherArray];
    }
    else
    {
    }
}

- (void)replaceObjectsInRangeForMY:(NSRange)range withObjectsFromArray:(NSArray *)otherArray range:(NSRange)otherRange
{
    if (range.location + range.length <= self.count && otherRange.location + otherRange.length <= otherArray.count) {
        [self replaceObjectsInRange:range withObjectsFromArray:otherArray range:otherRange];
    }
    else
    {
    }
}

- (void)insertObjectsForMY:(NSArray *)objects atIndexes:(NSIndexSet *)indexes
{
    if (nil != objects && indexes.count == objects.count && indexes.firstIndex <= self.count && indexes.lastIndex <= self.count) {
        [self insertObjects:objects atIndexes:indexes];
    }
    else
    {
    }
}

- (void)removeObjectsAtIndexesForMY:(NSIndexSet *)indexes
{
    if (indexes.firstIndex < self.count && indexes.lastIndex < self.count) {
        [self removeObjectsAtIndexes:indexes];
    }
    else
    {
    }
}

- (void)replaceObjectsAtIndexesForMY:(NSIndexSet *)indexes withObjects:(NSArray *)objects
{
    if (nil != objects && indexes.count == objects.count && indexes.firstIndex < self.count && indexes.lastIndex < self.count) {
        [self replaceObjectsAtIndexes:indexes withObjects:objects];
    }
    else
    {
    }
}


@end
