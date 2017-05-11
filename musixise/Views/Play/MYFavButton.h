//
//  MYFavButton.h
//  musixise
//
//  Created by wmy on 2017/4/25.
//  Copyright © 2017年 wmy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBlock)(BOOL isSelect);

@interface MYFavButton : UIButton

@property(nonatomic, copy) ClickBlock block;

+ (instancetype)favButton;

@end
