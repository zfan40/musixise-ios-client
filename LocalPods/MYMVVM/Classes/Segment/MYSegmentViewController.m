//
//  MYSegmentViewController.m
//  xiaplay
//
//  Created by wmy on 15/12/11.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import "MYSegmentViewController.h"
#import <MYUtils/NSArray+MYSafe.h>
#import "MYSegmentLabel.h"
#import <MYWidget/MYWidget.h>

#define kdefaultSmallScrollViewHeight 44
#define kSpace 5
#define kLabelTag 100

@interface MYSegmentViewController () <UIScrollViewDelegate>
/**
 *  用于存放title
 */
@property (nonatomic,strong) NSMutableArray *titleArray;
@property (nonatomic,strong) NSMutableArray *labelArray;
/**
 *  用于存放viewController
 */
@property (nonatomic,strong) NSMutableArray *viewControllerArray;
@property (nonatomic,strong) NSMutableArray *viewControllerNameArray;
@property (nonatomic,strong) UIScrollView *smallScrollView;
@property (nonatomic,strong) UIScrollView *bigScrollView;
@property (nonatomic,weak) MYSegmentLabel *lastLabel;



@end

@implementation MYSegmentViewController

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (void)viewDidLoad {
    self.smallScrollViewHeight = kdefaultSmallScrollViewHeight;
    self.space = kSpace;
    self.automaticallyAdjustsScrollViewInsets =NO;
    [super viewDidLoad];
    [self.view addSubview:self.smallScrollView];
    [self.view addSubview:self.bigScrollView];
    self.bigScrollView.height = self.view.height - self.smallScrollView.height - self.space - 64;
    if (![self playBarHidden]) {
        self.bigScrollView.height -= 50;
    }
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.bigScrollView.contentSize = CGSizeMake(self.bigScrollView.contentSize.width, self.bigScrollView.height);
    for (UIViewController *viewController in self.childViewControllers) {
        viewController.view.height = self.bigScrollView.height;
    }
}

#pragma mark - --------------------功能函数------------------

- (void)scrollToIndex:(NSInteger)index {
    //TODO: wmy
    self.bigScrollView.contentOffset = CGPointMake(self.bigScrollView.width * index, self.bigScrollView.contentOffset.y);
    [self scrollViewDidEndScrollingAnimation:self.bigScrollView];
}

- (void)addTitle {
    CGFloat labelWidth = 80;
    if (kScreenWidth / labelWidth > self.titleArray.count) {
        labelWidth = kScreenWidth / self.titleArray.count;
    } else {
        labelWidth = 80;
    }
    self.smallScrollView.contentSize = CGSizeMake(self.titleArray.count * labelWidth, self.smallScrollView.height);
    self.smallScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    for ( int i = 0; i < self.titleArray.count; i++) {
        NSString *title = [self.titleArray objectAtIndexForMY:i];
        MYSegmentLabel *label = [[MYSegmentLabel alloc] init];
        label.text = title;
        label.left = i * labelWidth;
        label.top = 0;
        label.width = labelWidth;
        label.height = self.smallScrollView.height;
        label.tag = i + kLabelTag;
        [self.labelArray addObject:label];
        label.userInteractionEnabled = YES;
        UITapGestureRecognizer *labelTap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                  action:@selector(onClicklabel:)];
        [label addGestureRecognizer:labelTap];
        [self.smallScrollView addSubview:label];
    }
    self.smallScrollView.frame = CGRectMake(0, 0, kScreenWidth, self.smallScrollView.height);
}

- (void)addViewController {
    MYBaseViewController *vc = self.viewControllerArray[0];
    [self.bigScrollView addSubview:vc.view];
    self.bigScrollView.contentSize = CGSizeMake(self.viewControllerArray.count * kScreenWidth, self.bigScrollView.height);
}

#pragma mark - --------------------手势事件------------------
- (void)onClicklabel:(UITapGestureRecognizer *)recognizer {
    if ([recognizer.view isKindOfClass:[MYSegmentLabel class]]) {
        MYSegmentLabel *label = (MYSegmentLabel *)recognizer.view;
        if (label == self.lastLabel) {
            return;
        }
        label.isChoose = YES;
        self.lastLabel.isChoose = NO;
        self.lastLabel = label;
        CGFloat offsetX = (label.tag - kLabelTag) * self.bigScrollView.frame.size.width;
        CGFloat offsetY = self.bigScrollView.contentOffset.y;
        CGPoint offset = CGPointMake(offsetX, offsetY);
        [self.bigScrollView setContentOffset:offset animated:YES];
    }
}
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------

//滚动结束后调用（代码导致）
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    // 获得索引
    NSUInteger index = scrollView.contentOffset.x / self.bigScrollView.frame.size.width;
    // 滚动标题栏
    MYSegmentLabel *titleLable = (MYSegmentLabel *)self.smallScrollView.subviews[index];
    CGFloat offsetx = titleLable.center.x - self.smallScrollView.frame.size.width * 0.5;
    CGFloat offsetMax = self.smallScrollView.contentSize.width - self.smallScrollView.frame.size.width;
    if (offsetx < 0) {
        offsetx = 0;
    }else if (offsetx > offsetMax){
        offsetx = offsetMax;
    }
    CGPoint offset = CGPointMake(offsetx, self.smallScrollView.contentOffset.y);
    [self.smallScrollView setContentOffset:offset animated:YES];
    MYBaseViewController *viewController = self.childViewControllers[index];
    for (int i = 0; i < self.labelArray.count; i++) {
        MYSegmentLabel *label = [self.labelArray objectAtIndexForMY:i];
        if (i == index) {
            label.isChoose = YES;
        } else {
            label.isChoose = NO;
        }
    }
    //如果nvc已经存在了，不作处理
    if (viewController.view.superview){
        return;
    }
    viewController.view.frame = scrollView.bounds;
    [self.bigScrollView addSubview:viewController.view];
//    viewController.view.left = index * scrollView.width;
}


 //滚动结束（手势导致）
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 取出绝对值 避免最左边往右拉时形变超过1
    CGFloat value = ABS(scrollView.contentOffset.x / scrollView.frame.size.width);
    NSUInteger leftIndex = (int)value;
    NSUInteger rightIndex = leftIndex + 1;
    CGFloat scaleRight = value - leftIndex;
    CGFloat scaleLeft = 1 - scaleRight;
    MYSegmentLabel *labelLeft = self.smallScrollView.subviews[leftIndex];
    labelLeft.scale = scaleLeft;
    // 考虑到最后一个板块，如果右边已经没有板块了 就不在下面赋值scale了
    if (rightIndex < self.titleArray.count) {
        MYSegmentLabel *labelRight = self.smallScrollView.subviews[rightIndex];
        labelRight.scale = scaleRight;
    }
}

#pragma mark - --------------------属性相关------------------

- (void)setArray:(NSArray *)array {
    _array = array;
    for (int i = 0; i < array.count; i++) {
        MYSegmentModel *model = [array objectAtIndexForMY:i];
        [self.titleArray addObject:model.title];
        MYTableViewController *viewController = [[NSClassFromString(model.viewController) alloc] init];
        [viewController setValuesForKeysWithDictionary:model.params];
        if (self.block) {
            NSDictionary *dict = self.block();
            for (NSString *key in dict.allKeys) {
                [viewController setValue:[dict objectForKey:key] forKey:key];
            }
        }
        [self addChildViewController:viewController];
        [self.viewControllerArray addObject:viewController];
        [self.viewControllerNameArray addObject:model.title];
        viewController.index = i;
        viewController.title = model.title;
        model.vc = viewController;
    }
    [self addTitle];
    [self addViewController];
    if ([[self.smallScrollView.subviews objectAtIndexForMY:0] isKindOfClass:[MYSegmentLabel class]]) {
        MYSegmentLabel *label = [self.smallScrollView.subviews objectAtIndexForMY:0];
        label.isChoose = YES;
        self.lastLabel = label;
    }
}

- (UIScrollView *)bigScrollView {
    if (!_bigScrollView) {
        _bigScrollView = [[UIScrollView alloc] init];
        _bigScrollView.width = kScreenWidth;
        _bigScrollView.height = kScreenHeight - 0 - self.space - self.smallScrollViewHeight;
        _bigScrollView.left = 0;
        _bigScrollView.top = self.smallScrollView.bottom + self.space;
        _bigScrollView.pagingEnabled = YES;
        _bigScrollView.delegate = self;
        _bigScrollView.bounces = NO;
    }
    return _bigScrollView;
}

- (UIScrollView *)smallScrollView {
    if (!_smallScrollView) {
        _smallScrollView = [[UIScrollView alloc] init];
        _smallScrollView.width = kScreenWidth;
        _smallScrollView.height = self.smallScrollViewHeight;
        _smallScrollView.backgroundColor = theMYWidget.maskColor;
        _smallScrollView.left = 0;
        _smallScrollView.top = 0;
        _smallScrollView.bounces = NO;
    }
    return _smallScrollView;
}

- (NSMutableArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

- (NSMutableArray *)viewControllerArray {
    if (!_viewControllerArray) {
        _viewControllerArray = [NSMutableArray array];
    }
    return _viewControllerArray;
}

- (NSMutableArray *)viewControllerNameArray {
    if (!_viewControllerNameArray) {
        _viewControllerNameArray = [NSMutableArray array];
    }
    return _viewControllerNameArray;
}

- (NSMutableArray *)labelArray {
    if (!_labelArray) {
        _labelArray = [NSMutableArray array];
    }
    return _labelArray;
}

@end


@implementation MYSegmentModel

- (NSMutableDictionary *)params {
    if (!_params) {
        _params = [NSMutableDictionary dictionary];
    }
    return _params;
}

- (void)refresh {
    [self.vc setValuesForKeysWithDictionary:self.params];
    [self.vc update];
}

- (void)backToTop {
    //TODO: wmy 不知道之前是用来做什么用的
}

@end
