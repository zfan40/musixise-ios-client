//
//  UIButton+MYStyle.h
//  Pods
//
//  Created by wmy on 16/1/28.
//
//

#import <UIKit/UIKit.h>
#import "MYWidget.h"

typedef  enum {
    MYButtonStyle_Normal_Small = 1,
    MYButtonStyle_Normal_Big,
    MYButtonStyle_Emphasize_Small,
    MYButtonStyle_Emphasize_Big,
    

} MYButtonStyle;

@interface UIButton (MYStyle)

@property (nonatomic,assign) MYButtonStyle myButtonStyle;

+ (UIButton *)buttonWithMYStyle:(MYButtonStyle)style title:(NSString *)title;

@end
