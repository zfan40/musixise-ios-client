//
//  MYLaunchViewController.m
//  musixise
//
//  Created by wmy on 16/9/28.
//  Copyright © 2016年 wmy. All rights reserved.
//  欢迎页

#import "MYLaunchViewController.h"
#import <MYWidget/UIButton+MYStyle.h>

@interface MYLaunchViewController () <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) NSArray *imageArray;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) UIButton *enterButton;
@end

@implementation MYLaunchViewController

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
}

- (void)initData {
    
}

- (void)initView {
    [self.view addSubview:self.scrollView];
    self.scrollView.frame = self.view.frame;

    for (int i = 0; i < self.imageArray.count; i++) {
        UIImage *image = [UIImage imageNamed:[self.imageArray objectAtIndex:i]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.width = kScreenWidth;
        imageView.height = kScreenHeight;
        imageView.left = 0;
        imageView.top = 0;
        [self.scrollView addSubview:imageView];
        imageView.left = i * kScreenWidth;
    }
    self.scrollView.contentSize = CGSizeMake(kScreenWidth * self.imageArray.count, kScreenHeight);
    self.pageControl.numberOfPages = self.imageArray.count;
    self.pageControl.width = kScreenWidth;
    self.pageControl.height = 40;
    self.pageControl.bottom = self.scrollView.bottom;
    self.enterButton.width = 100;
    self.enterButton.height = 40;
    self.enterButton.centerX = 0.5 * kScreenWidth;
    self.enterButton.centerY = kScreenHeight * 0.85;
    [self.view addSubview:self.pageControl];
    [self.view addSubview:self.enterButton];
    [self.enterButton addTarget:self action:@selector(onClickEnter) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (BOOL)isBarAlpha {
    return YES;
}

#pragma mark - --------------------功能函数------------------
#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------

- (void)onClickEnter {
    //TODO: wmy 从堆栈中删除launch页面
    [router routeUrl:@"musixise://page/MYMainViewController"];
}

#pragma mark - --------------------代理方法------------------

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int page = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = page;
}

#pragma mark - --------------------属性相关------------------

newInstanceStyleUIButton(enterButton, @"立即开启", MYButtonStyle_Normal_Small)

- (NSArray *)imageArray {
    if (!_imageArray) {
        _imageArray = @[
                        @"1",
                        @"2",
                        @"3"
                        ];
    }
    return _imageArray;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
    }
    return _pageControl;
}


- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}


@end
