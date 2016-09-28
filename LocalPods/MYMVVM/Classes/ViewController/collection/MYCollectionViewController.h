//
//  MYCollectionViewController.h
//  Pods
//
//  Created by wmy on 16/7/26.
//
//

#import "MYBaseViewController.h"
#import "MYCollectionView.h"
#import "MYBaseCollectionDelegate.h"


@interface MYCollectionViewController : MYBaseViewController

@property (nonatomic,assign) BOOL isBarAlpha;

@property (nonatomic,assign) BOOL refreshable;

@property (nonatomic,assign) BOOL needHeader;
/**
 *  是否可以上拉加载更多
 */
@property (nonatomic,assign) BOOL upRefreshable;
@property (nonatomic,strong) MYCollectionView *collectionView;
@property (nonatomic,weak) MYBaseCollectionDelegate *collectionDelegate;

- (void)collectionDelegateCallBack:(NSDictionary *)dict;

- (UICollectionViewScrollDirection)collectionDirection;

@end
