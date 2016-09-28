//
//  MYBaseDelegate.m
//  xiaplay
//
//  Created by wmy on 15/11/25.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import "MYBaseDelegate.h"
#import "MYBaseTableView.h"
#import "MYBaseViewModel.h"
#import "MYRouter.h"

@interface MYBaseDelegate ()



@end

@implementation MYBaseDelegate


- (void)setNavigationController:(MYNavigationController *)navigationController {
//    DLog(@"set navigationController");
    _navigationController = navigationController;
    router.navigationController = navigationController;
}


@end
