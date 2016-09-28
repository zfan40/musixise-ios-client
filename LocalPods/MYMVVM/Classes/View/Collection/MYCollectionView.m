//
//  MYCollectionView.m
//  Pods
//
//  Created by wmy on 16/7/26.
//
//

#import "MYCollectionView.h"
#import "MYBaseCollectionDelegate.h"

@implementation MYCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        self.separatorStyle = UITableViewStyleGrouped;
        self.backgroundColor = [UIColor clearColor];
//        self.separatorColor = [UIColor clearColor];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
//        self.separatorStyle = UITableViewStyleGrouped;
        self.backgroundColor = [UIColor clearColor];
//        self.separatorColor = [UIColor clearColor];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
//        self.separatorStyle = UITableViewStyleGrouped;
        self.backgroundColor = [UIColor clearColor];
//        self.separatorColor = [UIColor clearColor];
    }
    return self;
}

- (void)setCollectionDelegate:(MYBaseCollectionDelegate *)collectionDelegate {
    _collectionDelegate = collectionDelegate;
    self.delegate = collectionDelegate;
    self.dataSource = collectionDelegate;
}

@end
