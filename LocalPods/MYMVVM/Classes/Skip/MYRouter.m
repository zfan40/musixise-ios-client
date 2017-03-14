//
//  MYRouter.m
//  xiaplay
//
//  Created by wmy on 15/11/26.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import "MYRouter.h"
#import <objc/runtime.h>
#import <MYUtils/NSArray+MYSafe.h>
#import <MYUtils/MYJSONUtil.h>
#import <MYUtils/MYSafeUtil.h>
#import <MYUtils/NSMutableArray+ALMSafe.h>
#import "NSString+MYWarper.h"
#import "MYBaseViewController.h"
#import <MYUtils/MYDubugLog.h>
#import "MYRouterModel.h"
#import "MYRouteManagerModel.h"

@interface MYRouter ()

@property (nonatomic,strong) NSMutableArray<NSString *> *filePaths;
@property (nonatomic,strong) NSMutableArray<MYRouteManagerModel *> *managerArray;
@property (nonatomic,strong) NSMutableDictionary<NSString *,MYRouteManagerModel *> *routeDict;
@end

@implementation MYRouter

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------


- (instancetype)init {
    if (self = [super init]) {

    }
    return self;
}

- (void)setup:(MYNavigationController *)mainnavigation
withManagerModels:(NSArray<MYRouteManagerModel *>  *)managerModels {
    // 添加源数据
    self.managerArray = [NSMutableArray arrayWithArray:managerModels];
    [self configManagers];
    self.navigationController = mainnavigation;
    InfoLog(@"router 初始化完毕");
}


#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------
#pragma mark - --------------------功能函数------------------

#pragma mark - 对外方法

- (void)routeUrl:(NSString *)url {
    if (!isEmptyString(url)) {
        [self routeUrl:url withParam:nil];
    } else {
        DebugLog(@"url为空");
    }
}

- (void)routeUrl:(NSString *)url withParam:(NSDictionary *)dict {
    if ([url startsWith:@"musixise://"]) {
        // 说明为本应用的跳转
        NSRange range = [url rangeOfString:@"//"];
        NSString *relativeUrl = [url substringFromIndex:range.location + range.length];
        for (int i = 0; i < self.routeDict.allKeys.count; i++ ) {
            NSString *method = [self.routeDict.allKeys objectAtIndexForMY:i];
            MYRouterModel *route = ((MYRouteManagerModel *)[self.routeDict objectForKey:method]).routeModel;
            if ([self validate:url withReg:route.schemeUrl]) {
                NSString *method = route.method;
                NSMutableDictionary *resultDict = [NSMutableDictionary dictionaryWithDictionary:dict];
                NSArray *relaArray = [relativeUrl split:@"/"];
                NSMutableArray *paramsArray = [NSMutableArray arrayWithArray:relaArray];
                if (relaArray.count > 1) {
                    [resultDict setObject:relativeUrl forKey:@"scheme_url"];
                    [paramsArray removeObjectAtIndex:0];
                    [resultDict setObject:paramsArray forKey:@"params"];
                }
                NSString *manager = ((MYRouteManagerModel *)[self.routeDict objectForKey:method]).urlManagerName;
                [NSClassFromString(manager) performSelector:NSSelectorFromString(method)
                           withObject:resultDict afterDelay:0];
                break;
            }
        }
    } else {
        WarnLog(@"非法的url ： %@",url);
    }
}


- (void)configManagers {
    for (MYRouteManagerModel *managerModel in self.managerArray) {
        NSString *filePath = managerModel.filePath;
        if (!isEmptyString(filePath) &&
            ![self.filePaths containsObject:filePath]) {
            NSArray *jsonArray = [[MYJSONUtil sharedInstance] arrayWithJSONFilePath:filePath forKey:@"routers"];

            for (int i = 0; i < jsonArray.count; i ++) {
                MYRouterModel *model = [[MYRouterModel alloc] init];
                [model setValuesForKeysWithDictionary:[jsonArray objectAtIndex:i]];
                managerModel.routeModel = [model copy];
                [self.routeDict setObject:[managerModel copy] forKey:model.method];
            }
        }
    }
}

#pragma mark - 内部方法


- (BOOL)validate:(NSString *)string withReg:(NSString *)regExp {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regExp];
    return [predicate evaluateWithObject:string];
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

- (NSMutableArray<NSString *> *)filePaths {
    if (!_filePaths) {
        _filePaths = [NSMutableArray array];
    }
    return _filePaths;
}

- (NSMutableDictionary<NSString *,MYRouteManagerModel *> *)routeDict {
    if (!_routeDict) {
        _routeDict = [NSMutableDictionary<NSString *,MYRouteManagerModel *> dictionary];
    }
    return _routeDict;
}

@end
