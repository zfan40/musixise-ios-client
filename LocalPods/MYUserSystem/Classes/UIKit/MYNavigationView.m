//
//  MYNavigationView.m
//  Pods
//
//  Created by wmy on 16/9/29.
//
// 

#import "MYNavigationView.h"
#import <MYUtils/UIView+MYAdditons.h>

@implementation MYNavigationView

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    
}

+ (instancetype)navigationView {
    MYNavigationView *view = [[MYNavigationView alloc] init];
    
    return view;
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)addSubview:(UIView *)view {
    [super addSubview:view];
    // TODO: wmy 在加入view 后进行横向自适应
    CGFloat height = 0;
    CGFloat width = 0;
    for (UIView *subView in self.subviews) {
        if (subView.height > height) {
            height = subView.height;
        }
        subView.left = width;
        width += subView.width;
    }
    self.width = width;
    self.height = height;
}

#pragma mark - --------------------功能函数------------------
#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

@end
