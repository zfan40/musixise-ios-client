//
//  NSObject+ALMMethodSwizzling.m
//  TTPod
//
//  Created by chaoyang.zhang on 14-2-18.
//
//

#import "NSObject+ALMMethodSwizzling.h"
#import "ALMClassMethodPair.h"
#import "objc/runtime.h"

@implementation NSObject (ALMMethodSwizzling)

+ (void)replaceClassPair:(ALMClassMethodPair *)one withAnother:(ALMClassMethodPair *)another {
    Method originalMethod = class_getInstanceMethod(one.aClass, one.aSelector);
    Method overrideMethod = class_getInstanceMethod(another.aClass, another.aSelector);
    
    method_exchangeImplementations(originalMethod, overrideMethod);
}

+ (void)replaceOriginalSelector:(SEL)originalSelector withCustomSelector:(SEL)customSelector {
    [self replaceOriginalSelector:originalSelector withCustomSelector:customSelector inClass:[self class]];
}

+ (void)replaceOriginalSelector:(SEL)originalSelector withCustomSelector:(SEL)customSelector inClass:(Class)currentClass {
    ALMClassMethodPair *originalAddObjectPair = [ALMClassMethodPair classMethodPairWithClass:currentClass withSelector:originalSelector];
    ALMClassMethodPair *replacedAddObjectPair = [ALMClassMethodPair classMethodPairWithClass:currentClass withSelector:customSelector];
    
    [self replaceClassPair:originalAddObjectPair withAnother:replacedAddObjectPair];
}

- (void)replaceSelector:(SEL)oneSelector withClassPair:(ALMClassMethodPair *)another {
    ALMClassMethodPair *onePair = [[ALMClassMethodPair alloc] initWithClass:[self class] withSelector:oneSelector];
    [[self class] replaceClassPair:onePair withAnother:another];
}

@end
