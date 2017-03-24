//
//  MYRouterModel.m
//  Pods
//
//  Created by wmy on 16/6/3.
//
//

#import "MYRouterModel.h"

@implementation MYRouterModel
@synthesize path;
@synthesize host;
@synthesize method;
@synthesize example;

- (id)copyWithZone:(NSZone *)zone {
    MYRouterModel *copy = [[MYRouterModel alloc] init];
    copy.path = path;
    copy.host = host;
    copy.method = method;
    copy.example = example;
    return copy;
}

@end
