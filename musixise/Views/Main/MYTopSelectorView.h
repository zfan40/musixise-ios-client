//
//  MYTopSelectorView.h
//  musixise
//
//  Created by wmy on 2016/11/29.
//  Copyright © 2016年 wmy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYTopSelectorModel.h"

@protocol MYTopSelectorViewDelegate <NSObject>

- (void)topSelectorViewDidClickIndex:(NSInteger)index;

@end

@interface MYTopSelectorView : UIView

@property(nonatomic, weak) id<MYTopSelectorViewDelegate> delegate;

+ (instancetype)topSelectorViewWithModels:(NSArray <MYTopSelectorModel> *)modelArray maxWidth:(CGFloat)width;

- (void)setSelectIndex:(NSInteger)index;



@end
