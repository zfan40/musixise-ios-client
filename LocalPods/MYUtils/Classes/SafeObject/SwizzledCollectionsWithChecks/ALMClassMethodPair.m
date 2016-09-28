//
//  ClassMethodPair.m
//  TTPod
//
//  Created by chaoyang.zhang on 14-2-18.
//
//

#import "ALMClassMethodPair.h"
#import "objc/runtime.h"

@interface ALMClassMethodPair ()

@property(nonatomic, assign, readwrite) Class aClass;
@property(nonatomic, assign, readwrite) SEL aSelector;
@end

@implementation ALMClassMethodPair

- (id)initWithClass:(Class)oneClass withSelector:(SEL)oneSelector {
    if (self = [super init]) {
        if (oneClass != nil && oneSelector != nil) {
            _aClass = oneClass;
            _aSelector = oneSelector;
        }else {
            self = nil;
        }
        
    }
    
    return self;
}

+ (id)classMethodPairWithClass:(Class)oneClass withSelector:(SEL)oneSelector {
    ALMClassMethodPair *onePair = [[ALMClassMethodPair alloc] initWithClass:oneClass withSelector:oneSelector];
    
    return onePair;
}

@end
