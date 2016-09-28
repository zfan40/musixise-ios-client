//
//  NSMutableArray+ALMSafe.m
//  ALMLiveHouse
//
//  Created by myc on 15/9/28.
//  Copyright © 2015年 Alibaba. All rights reserved.
//

#import "NSMutableArray+ALMSafe.h"

@implementation NSMutableArray (ALMSafe)

- (void)addObjectForALM:(id)anObject
{
    if (nil != anObject) {
        [self addObject:anObject];
    }
    else
    {
    }
}

- (void)insertObjectForALM:(id)anObject atIndex:(NSUInteger)index
{
    if (nil != anObject && index <= self.count) {
        [self insertObject:anObject atIndex:index];
    }
    else
    {
    }
}

- (void)removeObjectAtIndexForALM:(NSUInteger)index
{
    if (index < self.count) {
        [self removeObjectAtIndex:index];
    }
    else
    {
    }
}

- (void)replaceObjectAtIndexForALM:(NSUInteger)index withObject:(id)anObject
{
    if (nil != anObject && index < self.count) {
        [self replaceObjectAtIndex:index withObject:anObject];
    }
    else
    {
    }
}

- (void)exchangeObjectAtIndexForALM:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2
{
    if (idx1 < self.count && idx2 < self.count) {
        [self exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
    }
    else
    {
    }
}

- (void)removeObjectForALM:(id)anObject inRange:(NSRange)range
{
    if (range.location + range.length <= self.count) {
        [self removeObject:anObject inRange:range];
    }
    else
    {
    }
}

- (void)removeObjectIdenticalToForALM:(id)anObject inRange:(NSRange)range
{
    if (range.location + range.length <= self.count) {
        [self removeObjectIdenticalTo:anObject inRange:range];
    }
    else
    {
    }
}

- (void)removeObjectsInRangeForALM:(NSRange)range
{
    if (range.location + range.length <= self.count) {
        [self removeObjectsInRange:range];
    }
    else
    {
    }
}

- (void)replaceObjectsInRangeForALM:(NSRange)range withObjectsFromArray:(NSArray *)otherArray
{
    if (range.location + range.length <= self.count) {
        [self replaceObjectsInRange:range withObjectsFromArray:otherArray];
    }
    else
    {
    }
}

- (void)replaceObjectsInRangeForALM:(NSRange)range withObjectsFromArray:(NSArray *)otherArray range:(NSRange)otherRange
{
    if (range.location + range.length <= self.count && otherRange.location + otherRange.length <= otherArray.count) {
        [self replaceObjectsInRange:range withObjectsFromArray:otherArray range:otherRange];
    }
    else
    {
    }
}

- (void)insertObjectsForALM:(NSArray *)objects atIndexes:(NSIndexSet *)indexes
{
    if (nil != objects && indexes.count == objects.count && indexes.firstIndex <= self.count && indexes.lastIndex <= self.count) {
        [self insertObjects:objects atIndexes:indexes];
    }
    else
    {
    }
}

- (void)removeObjectsAtIndexesForALM:(NSIndexSet *)indexes
{
    if (indexes.firstIndex < self.count && indexes.lastIndex < self.count) {
        [self removeObjectsAtIndexes:indexes];
    }
    else
    {
    }
}

- (void)replaceObjectsAtIndexesForALM:(NSIndexSet *)indexes withObjects:(NSArray *)objects
{
    if (nil != objects && indexes.count == objects.count && indexes.firstIndex < self.count && indexes.lastIndex < self.count) {
        [self replaceObjectsAtIndexes:indexes withObjects:objects];
    }
    else
    {
    }
}


@end
