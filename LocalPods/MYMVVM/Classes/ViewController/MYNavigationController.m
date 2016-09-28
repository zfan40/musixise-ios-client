//
//  CZNavigationController.m
//  xiaplay
//
//  Created by apple on 15-3-7.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "MYNavigationController.h"
#import "UIBarButtonItem+Item.h"
#import "MYTabBarViewController.h"
#import "MYBaseViewController.h"
#import <MYWidget/MYWidget.h>
#import <MYUtils/UIImage+MYImage.h>
#import <MYWidget/MYMoreView.h>
#import <MYWidget/UILabel+MYStyle.h>
#import <MYIconFont/MYButtonFactory.h>
#import <MYUtils/MYSingleDefine.h>


@interface MYNavigationController () <UINavigationControllerDelegate,MYMoreViewDelegate>
//@property (nonatomic,strong) id backDelegate;

@property (nonatomic,strong) MYMoreView *moreView;
@property (nonatomic,strong) NSArray *moreTitleArray;
@property (nonatomic,strong) UIButton *backButton;
@property (nonatomic,strong) UIImageView *rightMoreView;

@end

@implementation MYNavigationController

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------
+ (void)initialize
{
    // 获取当前类下面的UIBarButtonItem
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    //
    // 设置导航条按钮的文字颜色
//    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
//    titleAttr[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    [item setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UINavigationBar appearance] setBarTintColor:[UIColor clearColor]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    // 实现滑动返回功能
    // 清空滑动返回手势的代理，就能实现滑动返回
    //    self.backDelegate = self.interactivePopGestureRecognizer.delegate;
    self.interactivePopGestureRecognizer.delegate = nil;
    // 设置导航条按钮的文字颜色
//    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
//    titleAttr[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    self.navigationBar.titleTextAttributes = titleAttr;
//    self.navigationBar.tintColor = [UIColor whiteColor];
    
}
#pragma mark - --------------------属性相关------------------


- (UIImageView *)rightMoreView {
    if (!_rightMoreView) {
        _rightMoreView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_icon_more_normal"]];
        _rightMoreView.width = 32;
        _rightMoreView.height = 32;
        UITapGestureRecognizer *myRightMoreTap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                  action:@selector(onclickMore)];
        [_rightMoreView addGestureRecognizer:myRightMoreTap];
#if DEBUG
        _rightMoreView.layer.borderColor = [UIColor blueColor].CGColor;
        _rightMoreView.layer.borderWidth = 1;
#endif
    }
    return _rightMoreView;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [MYButtonFactory buttonWithImageName:@"iconFont-quanjufanhui" size:24 color:theMYWidget.c2];
        _backButton.width = 30;
        _backButton.height = 30;
        UITapGestureRecognizer *mybackButtonTap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                  action:@selector(backToPre)];
        [_backButton addGestureRecognizer:mybackButtonTap];
    }
    return _backButton;
}

- (MYMoreView *)moreView {
    if (!_moreView) {
        _moreView = [MYMoreView moreViewWithTitleArray:self.moreTitleArray top:64];
        _moreView.delegate = self;
    }
    return _moreView;
}


#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (![viewController isKindOfClass:[MYBaseViewController class]]) {
        WarnLog(@"viewController 不是 baseviewController 的子类");
        return [super popToViewController:viewController animated:animated];
    } else {
        NSArray *array = [super popToViewController:viewController animated:NO];
        MYBaseViewController *baseViewController = (MYBaseViewController *)viewController;
        [self animationWithPopType:[baseViewController inComeType]];
        return array;
    }
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (![viewController isKindOfClass:[MYBaseViewController class]]) {
        [super pushViewController:viewController animated:animated];
    } else {
        switch ([(MYBaseViewController *)viewController inComeType]) {
            case MYBaseViewControllerTypePush:
            {
                CATransition *transition = [CATransition animation];
                transition.duration = 0.15;
                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                transition.type = kCATransitionPush;
                transition.subtype = kCATransitionFromRight;
                transition.delegate = self;
                [self.view.layer addAnimation:transition forKey:nil];
                self.navigationBarHidden = NO;
                break;
            }
            case MYBaseViewControllerTypeModal:
            {
                
                CATransition *transition = [CATransition animation];
                transition.duration = 0.15;
                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                transition.type = kCATransitionPush;
                transition.subtype = kCATransitionFromTop;
                transition.delegate = self;
                [self.view.layer addAnimation:transition forKey:nil];
                self.navigationBarHidden = NO;
                break;
            }
        }
        [super pushViewController:viewController animated:NO];
    }
    
    // 设置非根控制器的导航条的内容
    if (self.viewControllers.count != 1) {// 非根控制器
        // 设置导航条的内容
        // 如果把导航条上的返回按钮覆盖，滑动返回不生效
        if (![(MYBaseViewController *)viewController leftItemHidden]) {
            
            viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
            viewController.navigationItem.leftBarButtonItem.target = self;
            viewController.navigationItem.leftBarButtonItem.action = @selector(backToPre);
        }
        if (![(MYBaseViewController *)viewController rightItemHidden]) {
            viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightMoreView];
            viewController.navigationItem.rightBarButtonItem.target = self;
            viewController.navigationItem.rightBarButtonItem.action = @selector(onclickMore);
        }
//        viewController.navigationController.navigationBar.backItem.hidesBackButton = YES;
        viewController.navigationItem.hidesBackButton = YES;
    } else {
        if ([self.tabBarController isKindOfClass:[MYTabBarViewController class]]) {
            self.tabBarController.tabBar.hidden = NO;
        }
    }
    
    if ([self.topViewController isKindOfClass:[MYBaseViewController class]]) {
        MYBaseViewController *tableViewController = (MYBaseViewController *)self.topViewController;
        self.moreTitleArray = [tableViewController moreTitleArray];
    }
}

#pragma mark - --------------------功能函数------------------


- (void)animationWithPopType:(MYBaseViewControllerType)type {
    switch (type) {
        case MYBaseViewControllerTypePush:
        {
            CATransition *transition = [CATransition animation];
            transition.duration = 0.2;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromLeft;
            transition.delegate = self;
            [self.view.layer addAnimation:transition forKey:nil];
            self.navigationBarHidden = NO;
            break;
        }
        case MYBaseViewControllerTypeModal:
        {
            
            CATransition *transition = [CATransition animation];
            transition.duration = 0.2;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromBottom;
            transition.delegate = self;
            [self.view.layer addAnimation:transition forKey:nil];
            self.navigationBarHidden = NO;
            break;
        }
    }
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------



- (void)backToPre {
    UIViewController *viewController = [self popViewControllerAnimated:NO];
    
    if ([viewController isKindOfClass:[MYBaseViewController class]]) {
        MYBaseViewController *baseViewController = (MYBaseViewController *)viewController;
        [self animationWithPopType:[baseViewController inComeType]];
        
    }
}

- (void)onclickMore {
    [self.moreView show];
}

- (void)backToRoot {
    [self popToRootViewControllerAnimated:YES];
}

#pragma mark - --------------------代理方法------------------

#pragma mark MYMoreViewDelegate

- (void)moreView:(MYMoreView *)moreView didClickIndex:(NSInteger)index {
    if ([self.topViewController isKindOfClass:[MYBaseViewController class]]) {
        MYBaseViewController *tableViewController = (MYBaseViewController *)self.topViewController;
        [tableViewController clickMoreWithIndex:index];
    }
}

@end
