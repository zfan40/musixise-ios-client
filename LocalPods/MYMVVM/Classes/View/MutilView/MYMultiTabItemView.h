//
//  MYMultiTabItemView.h
//  Pods
//
//  Created by wmy on 16/7/26.
//
//  multitableView中的tab Item

#import <UIKit/UIKit.h>

@interface MYMultiTabItemView : UIView

@property (nonatomic,assign) BOOL selected;

- (void)setTitle:(NSString *)title;
- (void)setSubTitle:(NSString *)subTitle;

@end
