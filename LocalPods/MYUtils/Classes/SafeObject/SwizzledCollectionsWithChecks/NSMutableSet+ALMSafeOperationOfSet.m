//
//  NSMutableSet+SafeOperationOfSet.m
//  TTPod
//
//  Created by chaoyang.zhang on 14-2-18.
//
//

#import "NSMutableSet+ALMSafeOperationOfSet.h"
#import "NSObject+ALMMethodSwizzling.h"
#import "ALMClassMethodPair.h"
#import "NSString+ALMCreateClassFromString.h"

static NSString * const TTMutableSetString = @"X19OU1NldE0=";

@implementation NSMutableSet (ALMSafeOperationOfSet)

+ (void)load {
    Class currentClass = [TTMutableSetString createClassWithOriginalEncoding];

    ALMClassMethodPair *originalAddObjectPair = [ALMClassMethodPair classMethodPairWithClass:currentClass withSelector:@selector(addObject:)];
    
    ALMClassMethodPair *replacedAddObjectPair = [ALMClassMethodPair classMethodPairWithClass:currentClass withSelector:@selector(addSafeObject:)];
    
    [self replaceClassPair:originalAddObjectPair withAnother:replacedAddObjectPair];
}

- (void)addSafeObject:(id)object {
    if (object != nil) {
        [self addSafeObject:object];
    }
}

@end
