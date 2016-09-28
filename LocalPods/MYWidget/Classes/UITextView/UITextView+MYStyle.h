//
//  UITextView+MYStyle.h
//  Pods
//
//  Created by wmy on 16/1/29.
//
//

#import <UIKit/UIKit.h>
#import "MYWidget.h"
@interface UITextView (MYStyle)

+ (UITextView *)textViewWithWidgetStyle:(MYWidgetStyle)style;

@property (nonatomic,assign) MYWidgetStyle textViewStyle;

@end
