//
//  UIButton+MYStyle.m
//  Pods
//
//  Created by wmy on 16/1/28.
//
//

#import "UIButton+MYStyle.h"
#import "MYWidget.h"
#import <MYUtils/UIView+MYAdditons.h>
#import <objc/runtime.h>

static int charStyle;
static const void *innerStyle = &innerStyle;
@interface UIButton ()


@property (nonatomic,assign) MYButtonStyle myButtonStyle;

@end


@implementation UIButton (MYStyle)
@dynamic myButtonStyle;
+ (UIButton *)buttonWithMYStyle:(MYButtonStyle)style title:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.myButtonStyle = style;
    return button;
}

- (MYButtonStyle)myButtonStyle {
    NSString *keyValue = objc_getAssociatedObject(self, innerStyle);
    unsigned long enumValue = keyValue.longLongValue;
    return (MYButtonStyle)enumValue;
}

- (void)setMyButtonStyle:(MYButtonStyle)myButtonStyle {
    charStyle = myButtonStyle;
        objc_setAssociatedObject(self, innerStyle, [NSString stringWithFormat:@"%d",myButtonStyle], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    UIColor *titleColor;
    UIFont *titleFont;
    UIColor *disableColor;
    UIColor *borderColor;
    UIColor *backColor;
    BOOL isSetStyle = YES;
    switch (myButtonStyle) {
        case MYButtonStyle_Normal_Big:
            titleColor = theMYWidget.c2;
            borderColor = theMYWidget.c2;
            backColor = theMYWidget.c2_a20;
            self.width = 150;
            self.height = 40;

            titleFont = theMYWidget.f3;
            break;
        case MYButtonStyle_Normal_Small:
            titleColor = theMYWidget.c2;
            borderColor = theMYWidget.c2;
            backColor = theMYWidget.c2_a20;
            self.width = 70;
            self.height = 30;
            titleFont = theMYWidget.f2;
            break;
            
        case MYButtonStyle_Emphasize_Big:
            titleColor = theMYWidget.c1;
            borderColor = theMYWidget.c1;
            backColor = theMYWidget.c1_a20;
            self.width = 150;
            self.height = 40;
            titleFont = theMYWidget.f3;
            break;
            
        case MYButtonStyle_Emphasize_Small:
            titleColor = theMYWidget.c1;
            borderColor = theMYWidget.c1;
            backColor = theMYWidget.c1_a20;
            titleFont = theMYWidget.f2;
            self.width = 70;
            self.height = 30;
            break;
            default:
            isSetStyle = NO;
            break;
    }
    
    if (!isSetStyle) {
        return;
    }
    disableColor = theMYWidget.c1_a20;
    [self setTitleColor:titleColor forState:UIControlStateNormal];
    [self setTitleColor:disableColor forState:UIControlStateDisabled];
    self.titleLabel.font = titleFont;
    [self setBackgroundImage:[self imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
    [self setBackgroundImage:[self imageWithColor:backColor] forState:UIControlStateHighlighted];
    [self setBackgroundImage:[self imageWithColor:[UIColor clearColor]] forState:UIControlStateDisabled];
    if (self.enabled) {
        self.borderColor = borderColor;
    } else {
        self.borderColor = disableColor;
    }
    self.layer.borderWidth = 1;
    self.cornerRadius = self.height * 0.5;

}


//FIXME: setenable
//- (void)setEnabled:(BOOL)enabled {
//    [super setEnabled:enabled];
//    if (charStyle) {
//        [self setMyButtonStyle:charStyle];
//    }
//}

//  颜色转换为背景图片
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
