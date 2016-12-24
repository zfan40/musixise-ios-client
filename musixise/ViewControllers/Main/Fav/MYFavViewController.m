//
//  MYFavViewController.m
//  musixise
//
//  Created by wmy on 2016/11/29.
//  Copyright © 2016年 wmy. All rights reserved.
//

#import "MYFavViewController.h"
#import "MYTopSelectorView.h"
#import "MYFavWorksOfArtViewController.h"
#import "MYFavArtistViewController.h"

#define kTabBarItemHeight 50
#define kNavigationBarHeight 64

@interface MYTopSelectorModelImp : NSObject <MYTopSelectorModel>

@property(nonatomic, strong) NSString *title;
@property(nonatomic, assign) CGFloat fontSize;
@property(nonatomic, strong) UIColor *normalColor;
@property(nonatomic, strong) UIColor *selectedColor;
@property(nonatomic, strong) MYBaseViewController *vc;

@end

@implementation MYTopSelectorModelImp

@end

@interface MYFavViewController () <MYTopSelectorViewDelegate,UIScrollViewDelegate>

@property(nonatomic, strong) MYTopSelectorView *topSelectorView;
@property(nonatomic, strong) NSMutableArray<MYTopSelectorModel> *topSelectorArray;
@property(nonatomic, strong) UIScrollView *scrollView;

@end

@implementation MYFavViewController

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
}

- (void)initData {
    //TODO: wmy UI
    MYTopSelectorModelImp *artistModel = [[MYTopSelectorModelImp alloc] init];
    artistModel.title = @"艺人";
    artistModel.normalColor = [UIColor whiteColor];
    artistModel.selectedColor = [UIColor blueColor];
    artistModel.vc = [[MYFavArtistViewController alloc] init];
    
    MYTopSelectorModelImp *actModel = [[MYTopSelectorModelImp alloc] init];
    actModel.title = @"作品";
    actModel.normalColor = [UIColor whiteColor];
    actModel.selectedColor = [UIColor blueColor];
    actModel.vc = [[MYFavWorksOfArtViewController alloc] init];
    
    [self.topSelectorArray addObject:artistModel];
    [self.topSelectorArray addObject:actModel];
}

- (void)initView {
    [self.view addSubview:self.scrollView];
    CGFloat height = self.view.height - kTabBarItemHeight - kNavigationBarHeight;
    self.scrollView.size = CGSizeMake(kScreenWidth, height);
    self.scrollView.left = 0;
    self.scrollView.top = 0;
    self.scrollView.contentSize = CGSizeMake(kScreenWidth * self.topSelectorArray.count, height);
    for (int i = 0; i < self.topSelectorArray.count; i++) {
        MYTopSelectorModelImp *imp = [self.topSelectorArray objectAtIndex:i];
        UIView *view = imp.vc.view;
        view.height = self.scrollView.height;
        [self.scrollView addSubview:view];
        view.left = kScreenWidth * i;
    }
    self.navigationItem.titleView = self.topSelectorView;
    [self.topSelectorView setSelectIndex:0];
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (MYNoDataType)noDataType {
    //TODO: wmy 
    return MYNoDataViewType_Hidden;
}
#pragma mark - --------------------功能函数------------------
#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / kScreenWidth;
    [self.topSelectorView setSelectIndex:index];
}

#pragma mark MYTopSelectorViewDelegate

- (void)topSelectorViewDidClickIndex:(NSInteger)index {
    // 点击头部按钮进行页面更换
    CGFloat width = kScreenWidth * index;
    [self.scrollView setContentOffset:CGPointMake(width, 0) animated:YES];

}

#pragma mark - --------------------属性相关------------------

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (NSMutableArray<MYTopSelectorModel> *)topSelectorArray {
    if (!_topSelectorArray) {
        _topSelectorArray = [NSMutableArray<MYTopSelectorModel> array];
    }
    return _topSelectorArray;
}

- (MYTopSelectorView *)topSelectorView {
    if (!_topSelectorView) {
        _topSelectorView = [MYTopSelectorView topSelectorViewWithModels:self.topSelectorArray
                                                               maxWidth:kScreenWidth];
        _topSelectorView.delegate = self;
    }
    return _topSelectorView;
}


@end
