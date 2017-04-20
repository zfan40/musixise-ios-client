//
//  CZTabBar.m
//  xiaplay
//
//  Created by apple on 15-3-4.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "MYTabBar.h"
#import "MYTabBarButton.h"
#import <MYUtils/UIView+MYAdditons.h>



@interface MYTabBar ()

@property (nonatomic, weak) MYTabBarButton *selectedButton;

@property(nonatomic, strong) NSMutableArray<MYTabBarButton *> *tabBarButtonArray;

@property(nonatomic, strong) NSMutableArray<MYTabBarModel> *tabBarModelArray;

@end

@implementation MYTabBar

#pragma mark - --------------------初始化--------------------

+ (instancetype)tabBarWithBarModels:(NSArray<MYTabBarModel> *)barModels {
    MYTabBar *tabBar = [[MYTabBar alloc] init];
    tabBar.width = kScreenWidth;
    tabBar.height = kTabBarHeight;
    CGFloat itemWidth = kScreenWidth / barModels.count;
    [tabBar.tabBarModelArray addObjectsFromArray:barModels];
    for (int i = 0; i < barModels.count; i++) {
        id<MYTabBarModel> model = [barModels objectAtIndex:i];
        MYTabBarButton *button = [MYTabBarButton tabBarButtonWithModel:model];
        button.tag = i;
        UITapGestureRecognizer *buttonTap = [[UITapGestureRecognizer alloc]initWithTarget:tabBar
                                                                                   action:@selector(onClickButton:)];
        [button addGestureRecognizer:buttonTap];
        [tabBar.tabBarButtonArray addObject:button];
        [tabBar addSubview:button];
    }
    [tabBar setNeedsLayout];
    return tabBar;
}

#pragma mark - --------------------父类方法重写--------------

// 调整子控件的位置
- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.tabBarButtonArray.count) {
        CGFloat w = kScreenWidth;
        CGFloat btnX = 0;
        CGFloat btnY = 0;
        CGFloat btnW = w / self.tabBarButtonArray.count;
        CGFloat btnH = self.height;
        int i = 0;
        // 设置tabBarButton的frame
        for (UIView *tabBarButton in self.tabBarButtonArray) {
            btnX = i * btnW;
            tabBarButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
            i++;
        }
    }
}

- (void)setSelectIndex:(NSInteger)index {
    if (index < 0 || index < self.tabBarButtonArray.count) {
        // 将之前的selectedButton的设置为normal
        MYTabBarButton *button = [self.tabBarButtonArray objectAtIndex:index];
        _selectedButton.selected = NO;
        button.selected = YES;
        _selectedButton = button;
        // 通知tabBarVc切换控制器，
        if ([_delegate respondsToSelector:@selector(tabBar:didClickButton:)]) {
            [_delegate tabBar:self didClickButton:button.tag];
        }
    }
}

#pragma mark - --------------------按钮事件------------------

// 点击tabBarButton调用
-(void)onClickButton:(UIRotationGestureRecognizer *)recognizer {
    UIView *button = recognizer.view;
    [self setSelectIndex:button.tag];
}
#pragma mark - --------------------属性相关------------------

- (NSMutableArray<MYTabBarButton *> *)tabBarButtonArray {
    if (!_tabBarButtonArray) {
        _tabBarButtonArray = [NSMutableArray<MYTabBarButton *> array];
    }
    return _tabBarButtonArray;
}

- (NSMutableArray<MYTabBarModel> *)tabBarModelArray {
    if (!_tabBarModelArray) {
        _tabBarModelArray = [NSMutableArray<MYTabBarModel> array];
    }
    return _tabBarModelArray;
}

@end
