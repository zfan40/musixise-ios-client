//
//  TTWalkThroughViewController.m
//  treeBank
//
//  Created by kebi on 16/4/28.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTWalkThroughViewController.h"
#import "TTUIViewAdditons.h"
#import "TTAppDelegate.h"

@interface TTWalkThroughViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong )UICollectionView *collectionView;
@property(nonatomic, strong)UIPageControl* pageControl;
@end

@implementation TTWalkThroughViewController{
    NSArray *_datas;
}


- (id)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectZero];
    self.pageControl.numberOfPages = 3;
    self.pageControl.currentPage = 0;
    
    UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    [collectionViewFlowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:collectionViewFlowLayout];
    collectionViewFlowLayout.minimumLineSpacing =0;
    collectionViewFlowLayout.minimumInteritemSpacing = 0;
    
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.frame = self.bounds;
    [collectionView registerClass:[UICollectionViewCell class]
       forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
    self.collectionView = collectionView;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self addSubview:collectionView];
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _datas = @[@"1",@"2",@"3"];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    [self addSubview:self.pageControl];
    [self.collectionView reloadData];
    return self;
}

-(BOOL)shouldHideNavigationBar{
    return YES;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    _collectionView.frame = self.bounds;
    _pageControl.frame = CGRectMake(0, self.height-40  , self.width, 30);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    UIImageView *imageView = [cell viewWithTag:9999 ];
    if(!imageView){
        imageView =[UIImageView new];
        [cell.contentView addSubview:imageView];
        imageView.backgroundColor =[UIColor blueColor];
    }
    UIButton *button = [cell viewWithTag:1111 ];
    if(!button){
        button =[UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(onGo) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@"goUse"] forState:UIControlStateNormal];
        [cell addSubview:button];
    }
    imageView.frame = self.frame;
    NSString *imageName =[_datas objectAtIndex:indexPath.row];
    imageView.image =[UIImage imageNamed:imageName];
    
    button.hidden = !(indexPath.row==2);
    CGSize buttonImageSize = button.imageView.image.size;
    button.frame = CGRectMake( (self.width-buttonImageSize.width)/2.0, self.height-50-buttonImageSize.height, buttonImageSize.width, buttonImageSize.height);
    return cell;
}

-(void)onGo{
    [self removeFromSuperview];
    TTAppDelegate *deleage =[UIApplication sharedApplication].delegate;
    [deleage.otherWindow resignKeyWindow];
    deleage.otherWindow = nil;
    [deleage.window makeKeyAndVisible];
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
                  layout:(UICollectionViewLayout*)collectionViewLayout
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

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x /scrollView.width;
    _pageControl.currentPage = index;
}




@end
