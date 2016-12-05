//
//  MYTopSelectorModel.h
//  musixise
//
//  Created by wmy on 2016/11/29.
//  Copyright © 2016年 wmy. All rights reserved.
//


@class MYBaseViewController;

@protocol MYTopSelectorModel <NSObject>

@property(nonatomic, strong) NSString *title;
@property(nonatomic, assign) CGFloat fontSize;
@property(nonatomic, strong) UIColor *normalColor;
@property(nonatomic, strong) UIColor *selectedColor;
@property(nonatomic, strong) MYBaseViewController *vc;

@end

