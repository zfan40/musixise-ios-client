//
//  MYBaseModel.m
//  xiaplay
//
//  Created by wmy on 15/11/23.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import "MYBaseModel.h"
#import <objc/runtime.h>
#import <MYUtils/MYDubugLog.h>

@interface MYBaseModel ()


@end

@implementation MYBaseModel

NSArray *_properties;

/**
 *  可选的参数
 *
 *  @param propertyName 参数名
 *
 *  @return 是否可选
 */
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    if ([[self optialProperty] containsObject:propertyName] ||
        [propertyName isEqualToString:@"more"]) {
        return YES;
    }
    return NO;
}

+ (NSArray *)optialProperty {
    return [self properties];
}

+ (NSArray *)properties {
    if (!_properties) {
        unsigned int outCount, i;
        objc_property_t *properties = class_copyPropertyList([self class], &outCount);
        NSMutableArray *keys = [[NSMutableArray alloc] initWithCapacity:outCount];
        for (i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            [keys addObject:propertyName];
            
        }
        free(properties);
        [keys addObject:@"more"];
        _properties = keys;
        DebugLog(@"properties = %@",keys);
    }
    return _properties;
}

- (NSDictionary *)modelDictionary {
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount;
    //属性的链表
    objc_property_t *properties =class_copyPropertyList([self class], &outCount);
    //遍历链表
    for (int i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        //获取属性字符串
        const char* propertyName =property_getName(property);
        //转换成NSString
        NSString *key = [NSString stringWithUTF8String:propertyName];
        //获取属性对应的value
        id value = [self valueForKey:key];
        if (value) {
            [props setObject:value forKey:key];
        }
    }
    //释放结构体数组内存
    free(properties);
    return props;
}

@end
