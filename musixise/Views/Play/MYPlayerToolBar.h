//
//  MYPlayerToolBarView.h
//  musixise
//
//  Created by wmy on 2017/4/25.
//  Copyright © 2017年 wmy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MYPlayerToolBar;

@protocol MYPlayerToolBarDelegate <NSObject>

- (void)playerToolBar:(MYPlayerToolBar *)playerToolBar didClickFav:(BOOL)isSelected;
- (void)playerToolBarDidClickShare:(MYPlayerToolBar *)playerToolBar;
- (void)playerToolBarDidClickComment:(MYPlayerToolBar *)playerToolBar;

@end

@interface MYPlayerToolBar : UIView

+ (instancetype)playerToolBar;

- (void)setComment:(NSInteger)comment;

@property(nonatomic, weak) id<MYPlayerToolBarDelegate> delegate;

@end
