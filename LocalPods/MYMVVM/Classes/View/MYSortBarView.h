//
//  MYSortBarView.h
//  xiaplay
//
//  Created by wmy on 15/12/18.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MYSortBarView;
@protocol MYSortBarViewDelegate <NSObject>

- (void)sortBarView:(MYSortBarView *)sortBarView withIndex:(CGFloat)index;

@end

@interface MYSortBarView : UIView
/**
 *  用于存放鱼眼的字母
 */
@property (nonatomic,strong) NSArray *sortArray;
@property (nonatomic,weak) id<MYSortBarViewDelegate> delegate;
@property (nonatomic,strong) UIColor *selectColor;
@property (nonatomic,strong) UIColor *defaultColor;
@property (nonatomic,assign) NSInteger index;

@end
