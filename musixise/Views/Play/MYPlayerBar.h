//
//  MYPlayerBar.h
//  musixise
//
//  Created by wmy on 2017/4/24.
//  Copyright © 2017年 wmy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYPlayBarProtocol.h"



@interface MYPlayerBar : UIView

@property(nonatomic, weak) id<MYPlayerBarProtocol> delegate;

+ (instancetype)playerBar;

- (void)setPreBtnSelected:(BOOL)selected;
- (void)setNextBtnSelected:(BOOL)selected;

- (void)setPlay:(BOOL)isPlay;

@end
