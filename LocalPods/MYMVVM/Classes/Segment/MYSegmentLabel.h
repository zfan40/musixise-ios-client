//
//  MYSegmentLabel.h
//  xiaplay
//
//  Created by wmy on 15/12/11.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYSegmentLabel : UILabel

@property (nonatomic,assign) CGFloat scale;
@property (nonatomic,assign) BOOL isChoose;
@property (nonatomic,strong) UIColor *defaultColor;
@property (nonatomic,strong) UIColor *chooseColor;

@end
