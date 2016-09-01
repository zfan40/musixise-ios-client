//
//  TTRouter.m
//  TTUISkeleton
//
//  Created by guanshanliu on 11/20/15.
//  Copyright © 2015 TTPod. All rights reserved.
//

#import "TTRouter.h"
#import "TTRouterImp.h"
@implementation TTRouter{
    NSMutableDictionary  *_routerMap;
}
+ (instancetype)defaultRouter {
    static dispatch_once_t onceToken;
    static TTRouter *router;
    dispatch_once(&onceToken, ^{
        router = [TTRouter new];
    });
    return router;
}
-(instancetype)init{
    if (self = [super init]) {
        _routerMap = [NSMutableDictionary dictionaryWithCapacity:5];
    }
    return self;
}
- (TTRouterResult *)route:(NSString *)urlString withParam:(NSDictionary *)param {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *sourceViewController;
    if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        sourceViewController = [(UINavigationController *)rootViewController topViewController];
    } else if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        sourceViewController = ({
            UITabBarController *tab = (UITabBarController *)rootViewController;
            tab.selectedViewController;
        });
    } else if ([rootViewController isKindOfClass:[UISplitViewController class]]) {
        sourceViewController = ({
            UISplitViewController *split = (UISplitViewController *)rootViewController;
            split.viewControllers.firstObject;
        });
    }
    
    return  [self route:urlString withParam:param fromViewController:sourceViewController];
}

- (TTRouterResult *)route:(NSString *)urlString withParam:(NSDictionary *)param fromViewController:(UIViewController *)viewController {
    // TODO: 跳转
    return [[TTRouterImp instance]route:urlString parameters:param];
}
- (void)addPattern:(NSString*)pattern withHandlerClassName:(NSString *)handlerClassName selectorName:(nonnull NSString *)selectorName{
    [self addRoute:pattern withObject:NSClassFromString(handlerClassName) selector:NSSelectorFromString(selectorName)];
}

- (void)addPattern:(NSString *)pattern withHandlerClassName:(NSString *)handlerClassName selectorName:(nonnull NSString *)selectorName forScheme:(NSString *)scheme{
    [self addRoute:pattern withObject: NSClassFromString(handlerClassName) selector:NSSelectorFromString(selectorName) forScheme:scheme];
}

-(void)addRoute:(NSString *)pattern withObject:(id)obj selector:(SEL)selector{
    return [self   addRoute:pattern withObject:obj selector:selector forScheme:@"treeBank"];
}
- (TTRouterImp *)routerForScheme:(NSString *)scheme{
    TTRouterImp *imp = nil;
    if (scheme == nil) {
         scheme = @"treeBank";
    }
    imp = _routerMap[scheme];
    if (!imp) {
        imp = [[TTRouterImp instance]newSubRouter:[NSString stringWithFormat:@"%@://",scheme]];
        _routerMap[scheme] = imp;
    }
    return  imp;
}
-(void)addRoute:(NSString *)pattern withObject:(id)obj selector:(SEL)selector forScheme:(NSString *)scheme{
   [[self routerForScheme:scheme] addRoute:pattern withObject:obj selector:selector,nil];
}
@end
