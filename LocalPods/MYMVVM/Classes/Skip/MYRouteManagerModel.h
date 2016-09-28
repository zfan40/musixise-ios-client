//
//  MYRouteManagerModel.h
//  Pods
//
//  Created by wmy on 16/8/25.
//
//

#import <Foundation/Foundation.h>
#import "MYRouterModel.h"

@interface MYRouteManagerModel : NSObject <NSCopying>

@property (nonatomic,strong,nonnull) NSString *filePath;
@property (nonatomic,strong,nonnull) NSString *urlManagerName;
@property (nonatomic,strong,nonnull) MYRouterModel *routeModel;
@end
