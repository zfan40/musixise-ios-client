//
//  MYBaseCollectionDelegate.h
//  Pods
//
//  Created by wmy on 16/7/26.
//
//  collectionDelegate 抽象类

#import "MYBaseDelegate.h"
#import "MYBaseItemView.h"
#import "MYCollectionView.h"
#import "MYCollectionViewCell.h"
#import <MYMVVM/MYRouter.h>


#define newInstanceCollection(collectionClassName,collectionName,collectionView,viewModel)  \
- (collectionClassName *)collectionName { \
if (!_##collectionName) { \
_##collectionName =[[collectionClassName alloc] initWithCollectionView:collectionView model:viewModel]; \
} \
return _##collectionName; \
}

@class MYCollectionViewController;

@interface MYBaseCollectionDelegate : MYBaseDelegate <MYBaseViewModelDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,weak) MYCollectionViewController *viewController;
@property (nonatomic,weak) MYCollectionView *collectionView;

- (instancetype)initWithCollectionView:(MYCollectionView *)collectionView model:(MYBaseViewModel *)model;

- (instancetype)initWithCollectionView:(MYCollectionView *)collectionView
                            model:(MYBaseViewModel *)model
                   viewController:(MYCollectionViewController *)viewController;

- (NSString *)identifier;
- (NSString *)headerIdentifier;

@end
