//
//  NSDictionary+Safe.h
//  xiami
//
//  Created by 彭 玉堂 on 13-7-18.
//
//

#import <Foundation/Foundation.h>

@interface NSDictionary(ALMSafe)

- (id)safeObjectForKey:(id)key;
- (int)intValueForKey:(id)key;
- (double)doubleValueForKey:(id)key;
- (NSString*)stringValueForKey:(id)key;
- (NSString*)unescapeStringForKey:(id)key;

@end


@interface NSMutableDictionary(Safe)

- (void)safeSetObject:(id)anObject forKey:(id)aKey;
- (void)setIntValue:(int)value forKey:(id)aKey;
- (void)setDoubleValue:(double)value forKey:(id)aKey;
- (void)setStringValueForKey:(NSString*)string forKey:(id)aKey;

@end

@interface NSArray (Exception)

- (id)objectForKey:(id)key;

@end
