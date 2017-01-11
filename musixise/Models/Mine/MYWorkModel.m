//
//  MYWorkModel.m
//  musixise
//
//  Created by wmy on 2016/12/25.
//  Copyright © 2016年 wmy. All rights reserved.
//

#import "MYWorkModel.h"

@implementation MYWorkModel

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"objId":@"id"}];
}

+ (NSArray *)optialProperty {
    return @[@"status",@"url",@"title",@"detail"];
}

@end
