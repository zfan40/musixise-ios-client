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

//@property (nonatomic, weak) UIButton *plusButton;

@property (nonatomic, strong) NSMutableArray *buttons;

@property (nonatomic, weak) UIButton *selectedButton;

@end

@implementation MYTabBar

#pragma mark - --------------------父类方法重写--------------

// 调整子控件的位置
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat w = kScreenWidth;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = w / self.items.count;
    CGFloat btnH = self.bounds.size.height;
    int i = 0;
    // 设置tabBarButton的frame
    for (UIView *tabBarButton in self.buttons) {
        btnX = i * btnW;
        tabBarButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
        i++;
    }
}
#pragma mark - --------------------按钮事件------------------

// 点击tabBarButton调用
-(void)btnClick:(UIButton *)button
{
    _selectedButton.selected = NO;
    button.selected = YES;
    _selectedButton = button;
    
    // 通知tabBarVc切换控制器，
    if ([_delegate respondsToSelector:@selector(tabBar:didClickButton:)]) {
        [_delegate tabBar:self didClickButton:button.tag];
    }
}
#pragma mark - --------------------属性相关------------------


- (NSMutableArray *)buttons
{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (void)setItems:(NSArray *)items
{
    _items = items;
    
    // 遍历模型数组，创建对应tabBarButton
    for (UITabBarItem *item in _items) {
        
        MYTabBarButton *btn = [MYTabBarButton buttonWithType:UIButtonTypeCustom];
        
        // 给按钮赋值模型，按钮的内容由模型对应决定
        btn.item = item;
        
        btn.tag = self.buttons.count;
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        
        if (btn.tag == 0) { // 选中第0个
            [self btnClick:btn];
            
        }
   
        [self addSubview:btn];
        
        // 把按钮添加到按钮数组
        [self.buttons addObject:btn];
    }
}



@end
