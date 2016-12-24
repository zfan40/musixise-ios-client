//
//  MYRootTabBarViewController.m
//  musixise
//
//  Created by wmy on 2016/11/28.
//  Copyright © 2016年 wmy. All rights reserved.
//

#import "MYRootTabBarViewController.h"
#import "MYMainViewController.h"
#import <MYIconFont/MYIconFont.h>
#import "MYMineViewController.h"
#import "MYFavViewController.h"
#import <MYUtils/UIImage+MYImage.h>
#import <MYUserSystem/MYUserUtils.h>
#import <MYUserSystem/MYUser.h>

@interface MYTabBarModelImp : NSObject <MYTabBarModel>

@property(nonatomic, strong) UIColor *normalColor;
@property(nonatomic, strong) UIColor *selectColor;
@property(nonatomic, strong) NSString *iconName;
@property(nonatomic, assign) CGFloat iconWidth;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, assign) CGFloat fontSize;
@property(nonatomic, strong) MYBaseViewController *vc;
@property(nonatomic, assign) BOOL hideNavigationBar;

@end

@implementation MYTabBarModelImp
@end

@implementation MYRootTabBarViewController

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
}

- (void)initData {
#if DEBUG
    MYUser *user = [MYUserUtils sharedInstance].user;
    [self showtip:[NSString stringWithFormat:@"用户id：%lld,用户名:%@",user.userId,user.username]];
#endif
}

- (void)initView {
    //TODO: wmy 在右上角添加三个点
//    self.navigationItem.rightBarButtonItem =
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (NSArray<MYTabBarModel> *)setUpAllChildViewController {
    // 首页
    NSMutableArray<MYTabBarModel> *array = [NSMutableArray<MYTabBarModel> array];
    
    MYTabBarModelImp *homeModel = [[MYTabBarModelImp alloc] init];
    homeModel.vc = [[MYFavViewController alloc] init];
    homeModel.iconName = @"iconFont-dibuyoule";
    homeModel.iconWidth = 24;
    homeModel.fontSize = 12;
    //TODO: wmy
    homeModel.normalColor = [UIColor blackColor];
    homeModel.selectColor = [UIColor orangeColor];
    homeModel.title = @"收藏";
    
    MYTabBarModelImp *mineModel = [[MYTabBarModelImp alloc] init];
    mineModel.vc = [[MYMineViewController alloc] init];
    mineModel.iconName = @"iconFont-dibuwode";
    mineModel.iconWidth = 24;
    mineModel.fontSize = 12;
    //TODO: wmy
    mineModel.normalColor = [UIColor blackColor];
    mineModel.selectColor = [UIColor orangeColor];
    mineModel.hideNavigationBar = YES;
    mineModel.title = @"我的";
    
    MYTabBarModelImp *listModel = [[MYTabBarModelImp alloc] init];
    listModel.vc = [[MYMainViewController alloc] init];
    listModel.iconName = @"iconFont-dibushiting";
    listModel.iconWidth = 24;
    listModel.fontSize = 12;
    //TODO: wmy
    listModel.normalColor = [UIColor blackColor];
    listModel.selectColor = [UIColor orangeColor];
    listModel.title = @"列表";
    
    [array addObject:homeModel];
    [array addObject:listModel];
    [array addObject:mineModel];
    return array;
}
#pragma mark - --------------------功能函数------------------
#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------


@end
