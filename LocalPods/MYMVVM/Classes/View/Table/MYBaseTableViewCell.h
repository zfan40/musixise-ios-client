//
//  MYTableViewCell.h
//  xiaplay
//
//  Created by wmy on 15/11/25.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYBaseItemView.h"
@interface MYBaseTableViewCell : UITableViewCell

@property (nonatomic,strong) MYBaseItemView *itemView;

/**
 *  初始化cell
 *
 *  @param itemView itemView
 *  @param string   identifier
 *
 *  @return self
 */
- (instancetype)initWithItemView:(MYBaseItemView *)itemView reuseIdentifier:(NSString *)string;

- (MYBaseItemView *)itemView;

@end
