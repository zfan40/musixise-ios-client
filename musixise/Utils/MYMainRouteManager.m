//
//  MYRouteUrlManager.m
//  xiaplay
//
//  Created by wmy on 16/8/25.
//  Copyright © 2016年 wmy. All rights reserved.
//

#import "MYMainRouteManager.h"
#import <MYMVVM/MYRouter.h>
#import <MYMVVM/MYBaseViewController.h>
#import <MYUtils/NSArray+ALMSafe.h>
#import <objc/runtime.h>

@implementation MYMainRouteManager

#pragma mark - 返回

+ (void)back:(NSDictionary *)dict {
    [router.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 页面跳转

+ (void)page:(NSDictionary *)dict {
    NSString *schemeUrl = [dict objectForKey:@"scheme_url"];
    NSRange range = [schemeUrl rangeOfString:@"/"];
    NSString *classString = [schemeUrl substringFromIndex:range.location + range.length];
    NSMutableDictionary *resultDict = [NSMutableDictionary dictionaryWithDictionary:dict];
    [resultDict setValue:nil forKey:@"scheme_url"];
    [resultDict setValue:nil forKey:@"params"];
    [self page:classString withDictionary:resultDict];
    
}

+ (void)page:(NSString *)classString withDictionary:(NSDictionary *)dict {
    Class class = NSClassFromString(classString);
    for (int i = 0; i < router.navigationController.viewControllers.count; i++) {
        UIViewController *viewController = [router.navigationController.viewControllers objectAtIndexForALM:i];
        NSString *vcName = [NSString stringWithUTF8String:object_getClassName(viewController)];
        if ([vcName isEqualToString:classString]) {
            if ([viewController isKindOfClass:[MYBaseViewController class]]) {
                MYBaseViewController *baseViewController = (MYBaseViewController *)viewController;
                if ([baseViewController mode] == MYBaseViewControllerModeOnlyOne) {
                    //TODO: wmy 不需要重新创建，直接pop
                    [router.navigationController popToViewController:viewController animated:YES];
                    return;
                }
            }
        }
    }// end of for
    NSObject *obj = [[class alloc] init];
    // 获取viewController的所有属性
    NSArray *propertyKeys = [self propertyKeys:classString];
    // 对照dict中的key，有的就将其设置value
    for (NSString* property in propertyKeys) {
        if ([[dict allKeys] containsObject:property]) {
            // 设置属性
            [obj setValue:[dict objectForKey:property] forKey:property];
        }
    }
    if (router.navigationController && [obj isKindOfClass:[MYBaseViewController class]]) {
        [router.navigationController pushViewController:(MYBaseViewController *)obj animated:YES];
    }
}


+ (NSArray*)propertyKeys:(NSString *)classString
{
    unsigned int outCount, i;
    
    objc_property_t *properties = class_copyPropertyList([NSClassFromString(classString) class], &outCount);
    NSMutableArray *keys = [[NSMutableArray alloc] initWithCapacity:outCount];
    
    for (i = 0; i < outCount; i++) {
        
        objc_property_t property = properties[i];
        
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        
        [keys addObject:propertyName];
        
    }
    free(properties);
    return keys;
}


@end
