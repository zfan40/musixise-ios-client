//
//  TTNavigator.m
//  Pods
//
//  Created by Li Jianfeng on 15/11/30.
//
//

#import "TTNavigator.h"
#import "TTViewController.h"
#import "TTInteractionController.h"
#import "TTHorizonInteractionController.h"
#import "TTViewControllerPresentStyle.h"
#import "TTAnimationController.h"
#import "TTModalAnimationController.h"
#import "TTPushAnimationController.h"
@interface TTNavigator()
@property(nonatomic,strong) TTInteractionController *interactionController;
-(void)setParams:(NSDictionary*)params withObj:(id)obj;
@end
@implementation TTNavigator
-(instancetype)init{
    if (self = [super init]) {
        self.interactionController = [TTHorizonInteractionController new];
    }
    return self;
}
-(void)dealloc{
    self.interactionController = nil;
}
+(instancetype)sharedInstance{
    __strong static TTNavigator *navi = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        navi = [TTNavigator new];
    });
    return navi;
}
-(void)setParams:(NSDictionary*)params withObj:(id)obj {
    for (NSString* key in params) {
        @try {
            [obj setValue:params[key] forKey:key];
        }
        @catch (NSException *exception) {
        }
    }
}

-(UIViewController *)showController:(Class)class withParam:(NSDictionary *)param{
    if (!class) {
#ifdef DEBUG
        NSLog(@"can not find view controller");
#endif
        return  nil;
    }
    BOOL animated = YES;
    BOOL duplicate = YES;//默认页面可重复
    NSNumber *animatedNumber = param[@"animated"];
    NSNumber *duplicateNumber  = param[@"duplicate"];
    if (animatedNumber &&[animatedNumber isKindOfClass:[NSNumber class] ]) {
        animated = [animatedNumber boolValue];
    }
    
    if (duplicateNumber &&[duplicateNumber isKindOfClass:[NSNumber class] ]) {
        duplicate = [duplicateNumber boolValue];
    }
    //如果页面不可重复 然后 判断是否有重复的页面
    if (!duplicate && [self checkDuplicate:class] ) {
        return nil;
    }
    return   [self pushControllerWithClass:class animated:animated withParam:param];
}
-(BOOL)checkDuplicate:(Class)class{
    UIViewController *viewController =  [self.navigationController.viewControllers lastObject];
    if ( viewController && [viewController isKindOfClass:class]) {
        return YES;
    }
    return NO;
}
-(BOOL)navigateURL:(NSString *)url presentStyle:(TTViewControllerPresentStyle)presentStyle withParam:(NSDictionary *)param{
    if ([url isEqualToString:@"ttpod://back"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    return false;
}
//-(void)checkStatusBar:(UIViewController *)viewController{
//    if ([viewController  respondsToSelector:@selector(statusBarStyle)]) {
//        XViewController *xviewController  = (XViewController *)viewController;
//        UIStatusBarStyle statusBarStyle = xviewController.statusBarStyle;
//        [[UIApplication sharedApplication]setStatusBarStyle:statusBarStyle];
//    }
//    
//}
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [navigationController setNavigationBarHidden:YES];
    [UIView setAnimationsEnabled:YES];
}
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    [self checkStatusBar:viewController];
    
    BOOL canGestureBack = NO;
    if ([viewController respondsToSelector:@selector(canDismissWithGesture)]) {
        canGestureBack = [(TTViewController *)viewController canDismissWithGesture];
    }
    if (canGestureBack) {
        [self.interactionController attachViewController:viewController withStyle:TTTransitionStylePush];
    }
}
-(UIViewController *)pushControllerWithClass:(Class) clazz animated:(BOOL)animated withParam:(NSDictionary *)param{
    if (clazz && [clazz isSubclassOfClass:[UIViewController class]]) {
        UIViewController *viewController = [clazz new];
        [self setParams:param withObj:viewController];
        if ( [( TTViewController *)viewController  presentStyle] == TTViewControllerPresentStyleModal && self.modalNavigationController) {
            [self.modalNavigationController pushViewController:viewController animated:animated];
        }else{
            [self.navigationController  pushViewController:viewController animated:YES &&animated];
        }
        return viewController;
    }
    return nil;
}

#pragma  mark ViewControllerTransition

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    BOOL isPostiveAnimation = operation ==UINavigationControllerOperationPop;
    TTViewControllerPresentStyle presentStyle = TTViewControllerPresentStyleNone;
    if (isPostiveAnimation) {
        presentStyle  =  [(TTViewController *)fromVC  presentStyle];
    }else{
        presentStyle = [(TTViewController *)toVC  presentStyle];
    }
    TTAnimationController *animation = [self animationControllerForPresentStyle:presentStyle];
    animation.isPositiveAnimation  = isPostiveAnimation;
    return animation;
}
-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    if([self.interactionController  isInteractive]){
        return self.interactionController;
    }
    
    return   nil;
}

-(TTAnimationController *)animationControllerForPresentStyle:(TTViewControllerPresentStyle )style{
   if (style == TTViewControllerPresentStyleModal) {
        return [TTModalAnimationController new];
    }else{
        return [TTPushAnimationController new];
    }
}

@end
