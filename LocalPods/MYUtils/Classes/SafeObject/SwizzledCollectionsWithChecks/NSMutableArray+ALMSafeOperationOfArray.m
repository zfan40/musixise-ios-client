//
//  NSMutableArray+SafeOperationOfArray.m
//  TTPod
//
//  Created by chaoyang.zhang on 14-2-18.
//
//

#import "NSMutableArray+ALMSafeOperationOfArray.h"
#import "NSObject+ALMMethodSwizzling.h"
#import "ALMClassMethodPair.h"
#import "NSString+ALMCreateClassFromString.h"

static NSString * const TTMutableArrayString = @"X19OU0FycmF5TQ==";

@implementation NSMutableArray (ALMSafeOperationOfArray)

+ (void)load {
    Class currentClass = [TTMutableArrayString createClassWithOriginalEncoding];
    
    ALMClassMethodPair *originalAddObjectPair = [ALMClassMethodPair classMethodPairWithClass:currentClass withSelector:@selector(addObject:)];
    ALMClassMethodPair *originalInsertObjectPair = [ALMClassMethodPair classMethodPairWithClass:currentClass withSelector:@selector(insertObject:atIndex:)];
    ALMClassMethodPair *originalReplaceObjectPair = [ALMClassMethodPair classMethodPairWithClass:currentClass withSelector:@selector(replaceObjectAtIndex:withObject:)];
    ALMClassMethodPair *originalSetObjectPair = [ALMClassMethodPair classMethodPairWithClass:currentClass withSelector:@selector(setObject:atIndexedSubscript:)];
    
    ALMClassMethodPair *replacedAddObjectPair = [ALMClassMethodPair classMethodPairWithClass:currentClass withSelector:@selector(addSafeObject:)];
    ALMClassMethodPair *replacedInsertObjectPair = [ALMClassMethodPair classMethodPairWithClass:currentClass withSelector:@selector(insertSafeObject:atIndex:)];
    ALMClassMethodPair *replacedReplaceObjectPair = [ALMClassMethodPair classMethodPairWithClass:currentClass withSelector:@selector(replaceSafeObjectAtIndex:withObject:)];
    ALMClassMethodPair *replacedSetObjectPair = [ALMClassMethodPair classMethodPairWithClass:currentClass withSelector:@selector(setSafeObject:atIndexedSubscript:)];
    
    [self replaceClassPair:originalAddObjectPair withAnother:replacedAddObjectPair];
    [self replaceClassPair:originalInsertObjectPair withAnother:replacedInsertObjectPair];
    [self replaceClassPair:originalReplaceObjectPair withAnother:replacedReplaceObjectPair];
    [self replaceClassPair:originalSetObjectPair withAnother:replacedSetObjectPair];

}

- (void)addSafeObject:(id)anObject {
    if (anObject != nil) {
        [self addSafeObject:anObject];
    }
}

- (void)insertSafeObject:(id)anObject atIndex:(NSUInteger)index {
    if (anObject != nil) {
        [self insertSafeObject:anObject atIndex:index];
    }
}

- (void)replaceSafeObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (anObject != nil) {
        [self replaceSafeObjectAtIndex:index withObject:anObject];
    }
}

- (void)setSafeObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
    if (obj != nil) {
        [self setSafeObject:obj atIndexedSubscript:idx];
    }
}

@end
