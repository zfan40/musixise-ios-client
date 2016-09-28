//
//  MYRouter.h
//  xiaplay
//
//  Created by wmy on 15/11/26.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import "MYBasicSingleton.h"
#import "MYNavigationController.h"
#define router [MYRouter sharedInstance]

@class MYRouteManagerModel;

@interface MYRouter : MYBasicSingleton

@property (nonatomic,weak) MYNavigationController *navigationController;

- (void)setup:(MYNavigationController *)mainnavigation
withManagerModels:(NSArray<MYRouteManagerModel *>  *)managerModels;

- (void)routeUrl:(NSString *)url;
- (void)routeUrl:(NSString *)url withParam:(NSDictionary *)dict;

@end
