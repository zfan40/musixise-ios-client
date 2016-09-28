//
//  MYBaseCollectionReusableView.h
//  Pods
//
//  Created by wmy on 16/9/7.
//
//

#import <UIKit/UIKit.h>

@class MYBaseItemView;

@interface MYBaseCollectionReusableView : UICollectionReusableView

@property (nonatomic,strong) MYBaseItemView *itemView;

- (void)refresh;

@end
