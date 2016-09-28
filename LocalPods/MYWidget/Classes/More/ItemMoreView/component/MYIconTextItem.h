//
//  MYItemMoreViewItemView.h
//  Pods
//
//  Created by wmy on 16/4/13.
//
//  icon + title

#import <UIKit/UIKit.h>

@interface MYIconTextItem : UIView

+ (instancetype)itemMoreViewItemViewWithIconfont:(NSString *)iconfont title:(NSString *)title;

- (void)setTitle:(NSString *)title;

- (void)updateIconFont:(NSString *)iconfont;

@end
