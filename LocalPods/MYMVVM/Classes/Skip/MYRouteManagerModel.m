//
//  MYRouteManagerModel.m
//  Pods
//
//  Created by wmy on 16/8/25.
//
//

#import "MYRouteManagerModel.h"

@implementation MYRouteManagerModel
@synthesize filePath;
@synthesize urlManagerName;
@synthesize routeModel;

- (id)copyWithZone:(NSZone *)zone {
    MYRouteManagerModel *copy = [[MYRouteManagerModel alloc] init];
    copy.filePath = filePath;
    copy.urlManagerName = urlManagerName;
    copy.routeModel = routeModel;
    return copy;
}

@end
