//
//  UITextField+MYStyle.h
//  Pods
//
//  Created by wmy on 16/6/7.
//
//

#import <UIKit/UIKit.h>
#import "MYWidget.h"

@interface UITextField (MYStyle)

+ (instancetype)textFieldWithWidgetStyle:(MYWidgetStyle)style;

@property (nonatomic,assign) MYWidgetStyle textViewStyle;

@end
