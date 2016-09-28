//
//  NSArray+ALMSafe.m
//  ALMLiveHouse
//
//  Created by myc on 15/9/28.
//  Copyright © 2015年 Alibaba. All rights reserved.
//

#import "NSArray+ALMSafe.h"

@implementation  NSArray (ALMSafe)

+ (id)arrayWithObjectForALM:(id)anObject
{
    if (nil != anObject) {
        return [self arrayWithObject:anObject];
    }
    else
    {
        return nil;
    }
    
}

- (id)objectAtIndexForALM:(NSUInteger)index
{
    
    if (index < self.count)
    {
        return [self objectAtIndex:index];
    }
    else
    {
        return nil;
    }
}

- (NSArray *)arrayByAddingObjectForALM:(id)anObject
{
    if (nil != anObject)
    {
        return [self arrayByAddingObject:anObject];
    }
    else
    {
        return nil;
    }
}

- (NSArray *)subarrayWithRangeForALM:(NSRange)range
{
    if (range.location+range.length <= self.count)
    {
        return [self subarrayWithRange:range];
    }
    else
    {
        return nil;
    }
    
}

- (void)getObjectsForALM:(id __unsafe_unretained [])objects range:(NSRange)range
{
    if (range.location+range.length <= self.count)
    {
        return [self getObjects:objects range:range];
    }
    else
    {
        return;
    }
    
}

- (NSArray *)objectsAtIndexesForALM:(NSIndexSet *)indexes
{
    if (indexes.firstIndex < self.count && indexes.lastIndex < self.count)
    {
        return [self objectsAtIndexes:indexes];
    }
    else
    {
        return nil;
    }
}

+ (NSArray *)arrayWithArrayForALM:(NSArray *) array
{
    @try {
        if (nil != array
            && [array count] > 0) {
            return [self arrayWithArray:array];
        }
        else
        {
            return nil;
        }
    }
    @catch (NSException *exception) {
        return nil;
    }
}

@end
