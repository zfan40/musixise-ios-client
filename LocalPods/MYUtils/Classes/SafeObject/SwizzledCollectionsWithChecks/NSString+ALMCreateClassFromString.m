//
//  NSString+ALMCreateClassFromString.m
//  TTPod
//
//  Created by chaoyang.zhang on 14-2-19.
//
//

#import "NSString+ALMCreateClassFromString.h"

@implementation NSString (ALMALMCreateClassFromString)

- (Class)createClassWithOriginalEncoding {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    NSString *className = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    Class currentClass = NSClassFromString(className);
    return currentClass;
}

@end
