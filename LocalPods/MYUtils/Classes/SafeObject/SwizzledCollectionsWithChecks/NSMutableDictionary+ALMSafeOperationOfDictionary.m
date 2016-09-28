//
//  NSMutableDictionary+SafeOperationOfDictionary.m
//  TTPod
//
//  Created by chaoyang.zhang on 14-2-18.
//
//

#import "NSMutableDictionary+ALMSafeOperationOfDictionary.h"
#import "ALMClassMethodPair.h"
#import "NSObject+ALMMethodSwizzling.h"
#import "NSString+ALMCreateClassFromString.h"

static NSString * const TTMutableDictionaryString = @"X19OU0RpY3Rpb25hcnlN";

@implementation NSMutableDictionary (ALMSafeOperationOfDictionary)

+ (void)load {
    Class currentClass = [TTMutableDictionaryString createClassWithOriginalEncoding];
    
    ALMClassMethodPair *originalRemovedObjectPair = [ALMClassMethodPair classMethodPairWithClass:currentClass withSelector:@selector(removeObjectForKey:)];
    ALMClassMethodPair *originalSetObjectPair = [ALMClassMethodPair classMethodPairWithClass:currentClass withSelector:@selector(setObject:forKey:)];
    ALMClassMethodPair *originalSetObjectForKeyedSubscript = [ALMClassMethodPair classMethodPairWithClass:currentClass withSelector:@selector(setObject:forKeyedSubscript:)];
    
    ALMClassMethodPair *replacedRemovedObjectPair = [ALMClassMethodPair classMethodPairWithClass:currentClass withSelector:@selector(removeSafeObjectForKey:)];
    ALMClassMethodPair *replacedSetObjectPair = [ALMClassMethodPair classMethodPairWithClass:currentClass withSelector:@selector(setSafeObject:forKey:)];
    ALMClassMethodPair *replacedSetObjectForKeyedSubscript = [ALMClassMethodPair classMethodPairWithClass:currentClass withSelector:@selector(setSafeObject:forKeyedSubscript:)];
    
    [self replaceClassPair:originalRemovedObjectPair withAnother:replacedRemovedObjectPair];
    [self replaceClassPair:originalSetObjectPair withAnother:replacedSetObjectPair];
    [self replaceClassPair:originalSetObjectForKeyedSubscript withAnother:replacedSetObjectForKeyedSubscript];
}

- (void)removeSafeObjectForKey:(id)key {
    if (key != nil) {
        [self removeSafeObjectForKey:key];
    }
}

- (void)setSafeObject:(id)anObject forKey:(id <NSCopying>) aKey {
    if (anObject != nil && aKey != nil) {
        [self setSafeObject:anObject forKey:aKey];
    }
}

- (void)setSafeObject:(id)anObject forKeyedSubscript:(id <NSCopying>)aKey {
    if (anObject != nil && aKey != nil) {
        if ([self respondsToSelector:@selector(setObject:forKeyedSubscript:)]) {
            [self setSafeObject:anObject forKeyedSubscript:aKey];
        }else {
            [self setSafeObject:anObject forKey:aKey];
        }
    }
}

@end
