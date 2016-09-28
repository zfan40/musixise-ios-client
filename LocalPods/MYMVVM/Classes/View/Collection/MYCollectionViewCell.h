//
//  MYCollectionViewCell.h
//  Pods
//
//  Created by wmy on 16/6/16.
//
//

#import <UIKit/UIKit.h>
#import "MYBaseItemView.h"

@interface MYCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) MYBaseItemView *itemView;

- (instancetype)initWithFrame:(CGRect)rect itemView:(MYBaseItemView *)itemView;

/**
 *  初始化cell
 *
 *  @param itemView itemView
 *  @param string   identifier
 *
 *  @return self
 */
- (instancetype)initWithItemView:(MYBaseItemView *)itemView reuseIdentifier:(NSString *)string;

@end
