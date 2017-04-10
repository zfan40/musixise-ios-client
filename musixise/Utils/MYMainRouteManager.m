//
//  MYRouteUrlManager.m
//  xiaplay
//
//  Created by wmy on 16/8/25.
//  Copyright © 2016年 wmy. All rights reserved.
//

#import "MYMainRouteManager.h"
#import <MYUtils/NSDictionary+ALMSafe.h>
#import <MYUtils/NSString+MYWarper.h>
#import <MYMVVM/MYRouter.h>
#import <MYMVVM/MYBaseViewController.h>
#import <MYUtils/NSArray+MYSafe.h>
#import <objc/runtime.h>
#import "MYWorkViewModel.h"
#import "MYPlayListManager.h"


@implementation MYMainRouteManager

#pragma mark - 返回

+ (void)back:(NSDictionary *)dict {
    [router.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 页面跳转

+ (void)page:(NSDictionary *)dict {
    NSString *classString = [dict objectForKey:@"routePath"];
    NSMutableDictionary *resultDict = [NSMutableDictionary dictionaryWithDictionary:dict];
    [resultDict setValue:nil forKey:@"routePath"];
    [self page:classString withDictionary:resultDict];
}

#pragma mark - 登录

+ (void)login:(NSDictionary *)dict {
    [router routeUrl:@"musixise://page/MYLoginViewController"];
}

/**
 播放一首歌

 @param dict 一首歌
 */
+ (void)play:(NSDictionary *)dict {
    DebugLog(@"dict");
    NSString *ids = [dict objectForKey:@"ids"];
    NSInteger index = [[dict objectForKey:@"index"] integerValue];
    NSArray *workIds = [ids split:@"-"];
    [thePlayListManager setPlayIds:workIds];
    thePlayListManager.playIndex = index;
    [thePlayListManager startPlaying];
}

+ (void)page:(NSString *)classString withDictionary:(NSDictionary *)dict {
    Class class = NSClassFromString(classString);
    for (int i = 0; i < router.navigationController.viewControllers.count; i++) {
        UIViewController *viewController = [router.navigationController.viewControllers objectAtIndexForMY:i];
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
