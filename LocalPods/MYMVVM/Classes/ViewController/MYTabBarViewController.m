//
//  CZTabBarController.m
//  xiaplay
//
//  Created by apple on 15-3-4.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "MYTabBarViewController.h"
#import "MYTabBar.h"
#import "MYNavigationController.h"
#import "UIImage+MYImage.h"

@interface MYTabBarViewController ()<CZTabBarDelegate>

@property (nonatomic, strong) NSMutableArray *items;


@end

@implementation MYTabBarViewController

- (NSMutableArray *)items
{
    if (_items == nil) {
        
        _items = [NSMutableArray array];
        
    }
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 添加所有子控制器
    [self setUpAllChildViewController];
    
 
    // 自定义tabBar
    [self setUpTabBar];
    
}


#pragma mark - 设置tabBar
- (void)setUpTabBar
{
    // 自定义tabBar
    MYTabBar *tabBar = [[MYTabBar alloc] initWithFrame:self.tabBar.bounds];
    tabBar.backgroundColor = [UIColor whiteColor];
    
    // 设置代理
    tabBar.delegate = self;
    
    // 给tabBar传递tabBarItem模型
    tabBar.items = self.items;
    
    // 添加自定义tabBar
    [self.tabBar addSubview:tabBar];
//    [self setValue:tabBar forKey:@"tabBar"];
    // 移除系统的tabBar
//    [self.tabBar removeFromSuperview];
}

#pragma mark - 当点击tabBar上的按钮调用
- (void)tabBar:(MYTabBar *)tabBar didClickButton:(NSInteger)index
{
    self.selectedIndex = index;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    NSLog(@"%@",self.tabBar.items);
    // 移除系统的tabBarButton
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButton removeFromSuperview];
        }
    }
}


#pragma mark - 添加所有的子控制器
- (void)setUpAllChildViewController {
//    // 首页
//    MYHomeViewController *home = [[MYHomeViewController alloc] init];
//    [self setUpOneChildViewController:home image:[UIImage imageNamed:@"tabbar_home"] selectedImage:[UIImage imageNamedWithOrignal:@"tabbar_home_selected"] title:@"天天"];
//    _home = home;
//    // 直播
//    MYLiveViewController *live = [[MYLiveViewController alloc] init];
//    [self setUpOneChildViewController:live image:[UIImage imageNamed:@"tabbar_message_center"] selectedImage:[UIImage imageNamedWithOrignal:@"tabbar_message_center_selected"] title:@"直播"];
//    // 音乐
//    MYMusicViewController *music = [[MYMusicViewController alloc] init];
//    [self setUpOneChildViewController:music image:[UIImage imageNamed:@"tabbar_discover"] selectedImage:[UIImage imageNamedWithOrignal:@"tabbar_discover_selected"] title:@"音乐"];
//    // 玩乐
//    MYPlayViewController *profile = [[MYPlayViewController alloc] init];
//    [self setUpOneChildViewController:profile image:[UIImage imageNamed:@"tabbar_profile"] selectedImage:[UIImage imageNamedWithOrignal:@"tabbar_profile_selected"] title:@"玩乐"];
//    // 幕后
//    MYBackgroundViewController *background = [[MYBackgroundViewController alloc] init];
//    [self setUpOneChildViewController:background image:[UIImage imageNamed:@"tabbar_profile"] selectedImage:[UIImage imageNamedWithOrignal:@"tabbar_profile_selected"] title:@"幕后"];
}
// navigationItem决定导航条上的内容
// 导航条上的内容由栈顶控制器的navigationItem决定

#pragma mark - 添加一个子控制器
- (void)setUpOneChildViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title
{
//    // navigationItem模型
//    vc.navigationItem.title = title;
//    
//    // 设置子控件对应tabBarItem的模型属性
//    vc.tabBarItem.title = title;
    vc.title = title;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage;
    
    // 保存tabBarItem模型到数组
    [self.items addObject:vc.tabBarItem];
    // initWithRootViewController底层会调用导航控制器的push，把跟控制器压入栈
    MYNavigationController *nav = [[MYNavigationController alloc] initWithRootViewController:vc];

    [self addChildViewController:nav];
}


@end
