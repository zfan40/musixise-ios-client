//
//  NSArray+safe.m
//  treeBank
//
//  Created by kebi on 16/5/13.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "NSArray+safe.h"

@implementation  NSArray (XSafe)

+ (id)arrayWithObjectForX:(id)anObject
{
    if (nil != anObject) {
        return [self arrayWithObject:anObject];
    }
    else
    {
        return nil;
    }
    
}

- (id)objectAtIndexForX:(NSUInteger)index
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

- (NSArray *)arrayByAddingObjectForX:(id)anObject
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

- (NSArray *)subarrayWithRangeForX:(NSRange)range
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

- (void)getObjectsForX:(id __unsafe_unretained [])objects range:(NSRange)range
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

- (NSArray *)objectsAtIndexesForX:(NSIndexSet *)indexes
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

+ (NSArray *)arrayWithArrayForX:(NSArray *) array
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
