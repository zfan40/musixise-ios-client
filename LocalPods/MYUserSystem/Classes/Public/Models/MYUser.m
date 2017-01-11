//
//  MYUser.m
//  Pods
//
//  Created by wmy on 2016/11/1.
//
//

#import "MYUser.h"
#import <objc/runtime.h>

@implementation MYUser

- (MYUserGenderType)genderType {
    //TODO: wmy 性别
    if ([self.gender isEqualToString:@"男"]) {
        return MYUserGenderTypeFemale;
    } else if ([self.gender isEqualToString:@"女"]) {
        return MYUserGenderTypeMale;
    } else {
        return MYUserGenderTypeUnKnown;
    }
}

- (NSDictionary *)dictWithProperty {
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
