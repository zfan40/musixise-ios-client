//
//  MYCommentButton.h
//  musixise
//
//  Created by wmy on 2017/4/25.
//  Copyright © 2017年 wmy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYCommentButton : UIButton

+ (instancetype)commentButton;

- (void)setComment:(NSInteger)commentNumber;

@end
