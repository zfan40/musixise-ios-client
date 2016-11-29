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
#import "MYListViewController.h"
#import <MYUtils/UIImage+MYImage.h>

@interface MYTabBarModelImp : NSObject <MYTabBarModel>

@property(nonatomic, strong) UIColor *normalColor;
@property(nonatomic, strong) UIColor *selectColor;
@property(nonatomic, strong) NSString *iconName;
@property(nonatomic, assign) CGFloat iconWidth;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, assign) CGFloat fontSize;
@property(nonatomic, strong) MYBaseViewController *vc;

@end

@implementation MYTabBarModelImp
@end

@implementation MYRootTabBarViewController

- (NSArray<MYTabBarModel> *)setUpAllChildViewController {
    // 首页
    NSMutableArray<MYTabBarModel> *array = [NSMutableArray<MYTabBarModel> array];
    
    MYTabBarModelImp *homeModel = [[MYTabBarModelImp alloc] init];
    homeModel.vc = [[MYMainViewController alloc] init];
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
    mineModel.title = @"我的";

    MYTabBarModelImp *listModel = [[MYTabBarModelImp alloc] init];
    listModel.vc = [[MYListViewController alloc] init];
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

@end
