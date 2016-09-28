//
//  MYBaseCollectionDelegate.m
//  Pods
//
//  Created by wmy on 16/7/26.
//
//

#import "MYBaseCollectionDelegate.h"

@implementation MYBaseCollectionDelegate


- (instancetype)initWithCollectionView:(MYCollectionView *)collectionView model:(MYBaseViewModel *)model {
    if (self = [super init]) {
        self.model = model;
        self.collectionView = collectionView;
    }
    return self;
}

- (instancetype)initWithCollectionView:(MYCollectionView *)collectionView model:(MYBaseViewModel *)model viewController:(MYCollectionViewController *)viewController {
    if (self = [super init]) {
        self.collectionView = collectionView;
        self.model = model;
        self.viewController = viewController;
    }
    return self;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeZero;
}

// 设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    //    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
    //    return headerView;
    return nil;
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}



- (NSString *)identifier {
    return @"";
}

- (NSString *)headerIdentifier {
    return @"";
}

@end
