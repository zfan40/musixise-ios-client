//
//  CZTabBarController.m
//  xiaplay
//
//  Created by apple on 15-3-4.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "MYTabBarViewController.h"
#import <MYWidget/MYTipsHelper.h>
#import <MYUtils/UIView+MYAdditons.h>
#import "MYNavigationController.h"
#import "UIImage+MYImage.h"
#import "MYBaseViewController.h"
#import "MYRouter.h"

@interface MYTabBarViewController () <MYTabBarDelegate>

@property (nonatomic, strong) NSMutableArray<UITabBarItem *> *items;
@property(nonatomic, strong) MYTabBar *myTabBar;


@end

@implementation MYTabBarViewController

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加所有子控制器
    NSArray *array = [self setUpAllChildViewController];
    for (int i = 0; i < array.count; i++) {
        id<MYTabBarModel> model = [array objectAtIndex:i];
        [self setUpOneChildViewControllerWithModel:model];
    }
    self.myTabBar.backgroundColor = [UIColor whiteColor];
    // 设置代理
    self.myTabBar.delegate = self;
    // 给tabBar传递tabBarItem模型
    // 添加自定义tabBar
    [self.view addSubview:self.myTabBar];
    self.myTabBar.bottom = self.view.height;
    // 移除系统的tabBar
    [self.tabBar removeFromSuperview];
    self.selectedIndex = 0;
    [self.myTabBar setSelectIndex:0];
    if (self.childViewControllers.count) {
        router.navigationController = [self.childViewControllers objectAtIndex:0];
    }
}

+ (instancetype)sharedInstance {
    static MYTabBarViewController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance=[[self alloc] init];
    });
    return sharedInstance;
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 移除系统的tabBarButton
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButton removeFromSuperview];
        }
    }
}

#pragma mark - --------------------功能函数------------------


- (void)showtip:(NSString *)tip {
    [[MYTipsHelper sharedInstance] showTips:tip];
}

// 添加所有的子控制器
- (NSArray<MYTabBarModel> *)setUpAllChildViewController {
    NSAssert(@"subclass must recode",nil);
    return nil;
}

- (MYNavigationController *)currentNavigationVC {
    return [self.viewControllers objectAtIndex:self.selectedIndex];
}

/**
 添加一个子控制器
 */
- (void)setUpOneChildViewControllerWithModel:(id<MYTabBarModel>)model {
    // navigationItem模型
    MYBaseViewController *vc = model.vc;
    vc.navigationItem.title = model.title;
    // 设置子控件对应tabBarItem的模型属性
    vc.tabBarItem.title = model.title;
    vc.title = model.title;
    vc.isTopVc = YES;
    // 保存tabBarItem模型到数组
    [self.items addObject:vc.tabBarItem];
    // initWithRootViewController底层会调用导航控制器的push，把跟控制器压入栈
    MYNavigationController *nav = [[MYNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

// navigationItem决定导航条上的内容
// 导航条上的内容由栈顶控制器的navigationItem决定

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------

#pragma mark - 当点击tabBar上的按钮调用

- (void)tabBar:(MYTabBar *)tabBar didClickButton:(NSInteger)index {
    self.selectedIndex = index;
    MYNavigationController *nav = [self.childViewControllers objectAtIndex:index];
    router.navigationController = nav;
}

#pragma mark - --------------------属性相关------------------

- (void)setHideTabBar:(BOOL)hideTabBar {
    _hideTabBar = hideTabBar;
    self.myTabBar.hidden = hideTabBar;
}

- (MYTabBar *)myTabBar {
    if (!_myTabBar) {
        _myTabBar = [MYTabBar tabBarWithBarModels:[self setUpAllChildViewController]];
        _myTabBar.delegate = self;
    }
    return _myTabBar;
}

- (NSMutableArray<UITabBarItem *> *)items {
    if (!_items) {
        _items = [NSMutableArray<UITabBarItem *> array];
    }
    return _items;
}


@end
