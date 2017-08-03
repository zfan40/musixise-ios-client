//
//  MYRouterUtils.m
//  musixise
//
//  Created by wmy on 2017/8/3.
//  Copyright © 2017年 wmy. All rights reserved.
//

#import "MYRouterUtils.h"
#import <MYMVVM/MYRouteManagerModel.h>

@implementation MYRouterUtils

- (NSArray *)routeArrayWithClassName:(NSString *)className jsonFile:(NSString *)jsonFile {
    NSMutableArray *array = [NSMutableArray array];
    MYRouteManagerModel *routeManagerModel = [[MYRouteManagerModel alloc] init];
    routeManagerModel.urlManagerName = className;
    routeManagerModel.filePath = [[NSBundle mainBundle] pathForResource:jsonFile ofType:@"json"];
    [array addObject:routeManagerModel];
    return array;
}

@end
