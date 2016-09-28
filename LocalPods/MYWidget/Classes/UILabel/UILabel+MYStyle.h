//
//  UILabel+MYStyle.h
//  Pods
//
//  Created by wmy on 16/1/29.
//
//

#import <UIKit/UIKit.h>
#import "MYWidget.h"




@interface UILabel (MYStyle)


@property (nonatomic,assign) MYWidgetStyle widgetStyle;

+ (UILabel *)labelWithStyle:(MYWidgetStyle)widgetStyle withTextAligment:(NSTextAlignment)textAlignment;

- (void)setSizeWithSize:(CGSize)size;

- (void)onChangeSkin;

@end
