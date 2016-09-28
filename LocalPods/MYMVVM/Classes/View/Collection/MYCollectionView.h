//
//  MYCollectionView.h
//  Pods
//
//  Created by wmy on 16/7/26.
//
//

#import <UIKit/UIKit.h>

@class MYBaseCollectionDelegate;

@interface MYCollectionView : UICollectionView

@property (nonatomic,weak) MYBaseCollectionDelegate *collectionDelegate;

@end
