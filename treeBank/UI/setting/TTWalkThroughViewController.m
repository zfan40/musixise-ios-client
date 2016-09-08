//
//  TTWalkThroughViewController.m
//  treeBank
//
//  Created by kebi on 16/4/28.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTAppDelegate.h"
#import "TTUIViewAdditons.h"
#import "TTWalkThroughViewController.h"

@interface TTWalkThroughViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation TTWalkThroughViewController {
    NSArray *_datas;
}

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.collectionView];
        _datas = @[@"1", @"2", @"3"];
        [self addSubview:self.pageControl];
        [self.collectionView reloadData];
    }
    return self;
}
#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
    self.pageControl.frame = CGRectMake(0, self.height - 40, self.width, 30);
}

- (BOOL)shouldHideNavigationBar {
    return YES;
}

#pragma mark - --------------------功能函数------------------

- (void)onGo {
    [self removeFromSuperview];
    TTAppDelegate *deleage = [UIApplication sharedApplication].delegate;
    [deleage.otherWindow resignKeyWindow];
    deleage.otherWindow = nil;
    [deleage.window makeKeyAndVisible];
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView
        dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])
                                  forIndexPath:indexPath];
    UIImageView *imageView = [cell viewWithTag:9999];
    if (!imageView) {
        imageView = [UIImageView new];
        [cell.contentView addSubview:imageView];
        imageView.backgroundColor = [UIColor blueColor];
    }
    UIButton *button = [cell viewWithTag:1111];
    if (!button) {
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(onGo) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@"goUse"] forState:UIControlStateNormal];
        [cell addSubview:button];
    }
    imageView.frame = self.frame;
    NSString *imageName = [_datas objectAtIndex:indexPath.row];
    imageView.image = [UIImage imageNamed:imageName];

    button.hidden = !(indexPath.row == 2);
    CGSize buttonImageSize = button.imageView.image.size;
    button.frame = CGRectMake((self.width - buttonImageSize.width) / 2.0, self.height - 50 - buttonImageSize.height,
                              buttonImageSize.width, buttonImageSize.height);
    return cell;
}

#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                             layout:(UICollectionViewLayout *)collectionViewLayout
    referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                             layout:(UICollectionViewLayout *)collectionViewLayout
    referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

#pragma mark UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _datas.count;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    _pageControl.currentPage = index;
}

#pragma mark - --------------------属性相关------------------

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        [collectionViewFlowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        collectionViewFlowLayout.minimumLineSpacing = 0;
        collectionViewFlowLayout.minimumInteritemSpacing = 0;
        _collectionView =
            [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:collectionViewFlowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.frame = self.bounds;
        [_collectionView registerClass:[UICollectionViewCell class]
            forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _collectionView.bounces = NO;
    }
    return _collectionView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        _pageControl.numberOfPages = 3;
        _pageControl.currentPage = 0;
    }
    return _pageControl;
}

@end
