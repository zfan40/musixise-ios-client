//
//  MYBaicSingleton.m
//  xiaplay
//
//  Created by wmy on 15/11/25.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import "MYBasicSingleton.h"
static NSMutableDictionary *singleDictionary = nil;
static NSRecursiveLock *RecursiveLock = nil;

@implementation MYBasicSingleton
+ (void)initialize {
    if (self == [MYBasicSingleton class]) {
        RecursiveLock = [[NSRecursiveLock alloc] init];
    }
}

+ (instancetype) shared
{
    return [self sharedInstance];
}

+ (instancetype)sharedInstance{
    [RecursiveLock lock];
    if (singleDictionary == nil) {
        singleDictionary = [[NSMutableDictionary alloc] init];
    }

    NSString *classObjectDescription = NSStringFromClass([self class]);
    id object = [singleDictionary objectForKey:classObjectDescription];
    if (object == nil) {
        object = [[super allocWithZone:NULL] init];
        [singleDictionary setObject:object forKey:classObjectDescription];
    }
    [RecursiveLock unlock];

    return object;
}

+ (void)releasesharedInstance{
    [RecursiveLock lock];
     if ([singleDictionary count] > 0) {
         NSString *classObjectDescription = NSStringFromClass([self class]);
         id object = nil;
         if ((object = [singleDictionary objectForKey:classObjectDescription]) != nil) {
             [singleDictionary removeObjectForKey:classObjectDescription];
             [object manuallyRelease];
         }
     }else {
         singleDictionary = nil;
     }
    [RecursiveLock unlock];
}

+ (id)allocWithZone:(NSZone *)zone{
    return [self sharedInstance];
}

+ (id)copyWithZone:(NSZone *)zone{
    return [self sharedInstance];
}

#pragma mark manual release

- (void)manuallyRelease {
    [RecursiveLock lock];
    NSString *classObjectDescription = NSStringFromClass([self class]);
    if ([singleDictionary objectForKey:classObjectDescription] == nil) {
    }
    [RecursiveLock unlock];
}
@end
