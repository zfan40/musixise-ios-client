//
//  MYPlayButton.h
//  musixise
//
//  Created by wmy on 2017/4/21.
//  Copyright © 2017年 wmy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBlock)(void);

@interface MYPlayButton : UIView

@property(nonatomic, copy) ClickBlock clickBlock;

+ (instancetype)playButton;

- (void)startAnimation;

- (void)stopAnimation;


@end
