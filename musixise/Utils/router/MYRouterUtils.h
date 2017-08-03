//
//  MYRouterUtils.h
//  musixise
//
//  Created by wmy on 2017/8/3.
//  Copyright © 2017年 wmy. All rights reserved.
//

#import <MYUtils/MYBasicSingleton.h>

@interface MYRouterUtils : MYBasicSingleton

- (NSArray *)routeArrayWithClassName:(NSString *)className jsonFile:(NSString *)jsonFile;

@end
