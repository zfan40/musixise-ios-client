//
//  NSArray+safe.h
//  treeBank
//
//  Created by kebi on 16/5/13.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (XSafe)

+ (id)arrayWithObjectForX:(id)anObject;
- (id)objectAtIndexForX:(NSUInteger)index;
- (NSArray *)arrayByAddingObjectForX:(id)anObject;
- (NSArray *)subarrayWithRangeForX:(NSRange)range;
- (void)getObjectsForX:(id __unsafe_unretained[])objects range:(NSRange)range;
- (NSArray *)objectsAtIndexesForX:(NSIndexSet *)indexes;
+ (NSArray *)arrayWithArrayForX:(NSArray *)array;
@end