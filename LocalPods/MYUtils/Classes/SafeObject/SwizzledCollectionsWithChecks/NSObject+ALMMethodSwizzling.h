//
//  NSObject+ALMMethodSwizzling.h
//  TTPod
//
//  Created by chaoyang.zhang on 14-2-18.
//
//

#import <Foundation/Foundation.h>

@class ALMClassMethodPair;

@interface NSObject (ALMALMMethodSwizzling)

+ (void)replaceClassPair:(ALMClassMethodPair *)one withAnother:(ALMClassMethodPair *)another;
+ (void)replaceOriginalSelector:(SEL)originalSelector withCustomSelector:(SEL)customSelector;
+ (void)replaceOriginalSelector:(SEL)originalSelector withCustomSelector:(SEL)customSelector inClass:(Class)currentClass;

- (void)replaceSelector:(SEL)oneSelector withClassPair:(ALMClassMethodPair *)another;

@end
