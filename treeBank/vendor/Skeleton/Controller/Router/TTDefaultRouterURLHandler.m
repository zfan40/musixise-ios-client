//
//  TTDefaultRouterURLHandler.m
//  Pods
//
//  Created by Li Jianfeng on 15/12/29.
//
//

#import "TTDefaultRouterURLHandler.h"
#import "TTNavigator.h"
#import "TTRouterContext.h"
@implementation TTDefaultRouterURLHandler
- (void)back:(TTRouterContext* )ctx {
    id viewCon =  [ctx.queryParams objectForKey:@"viewController"];
    Class viewController = NSClassFromString(viewCon);
    if (viewController == nil) {
        [[TTNavigator sharedInstance].navigationController popViewControllerAnimated:YES];
        return;
    }
    if ([viewController isSubclassOfClass:[UIViewController class]]) {
        NSArray *array = [TTNavigator sharedInstance].navigationController.viewControllers;
        for (UIViewController *vc in [array.reverseObjectEnumerator allObjects]) {
            if ([vc isKindOfClass:[viewController class]]) {
                [[TTNavigator sharedInstance].navigationController popToViewController:vc animated:YES];
                break;
            }
        }
    }
}
-(void)interPage:(TTRouterContext* )ctx{
    NSString *viewControllerName =ctx.matchPaths[0];
    [[TTNavigator sharedInstance]  showController:NSClassFromString(viewControllerName) withParam:ctx.queryParams];
}
@end
