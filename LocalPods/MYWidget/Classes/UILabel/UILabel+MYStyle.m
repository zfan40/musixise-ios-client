//
//  UILabel+MYStyle.m
//  Pods
//
//  Created by wmy on 16/1/29.
//
//

#import "UILabel+MYStyle.h"
#import <objc/runtime.h>
#import <MYUtils/MYDubugLog.h>
#import <MYUtils/NSArray+MYSafe.h>
#import <MYUtils/NSDictionary+ALMSafe.h>

char labelWidgetStyle;

static const void *innerStyle = &innerStyle;

@implementation UILabel (MYStyle)

- (void)dealloc {
    
}

+ (UILabel *)labelWithStyle:(MYWidgetStyle)widgetStyle withTextAligment:(NSTextAlignment)textAlignment {
    UILabel *label = [[UILabel alloc] init];
    label.widgetStyle = widgetStyle;
    label.textAlignment = textAlignment;
    
    return label;
}

- (void)onChangeSkin {
    [self setWidgetStyle:self.widgetStyle];
    [self sizeToFit];
}

- (MYWidgetStyle)widgetStyle {
    NSString *keyValue = objc_getAssociatedObject(self, innerStyle);
    unsigned long enumValue = keyValue.longLongValue;
    return (MYWidgetStyle)enumValue;
}

- (void)setWidgetStyle:(MYWidgetStyle)widgetStyle {
    objc_setAssociatedObject(self, innerStyle, [NSString stringWithFormat:@"%d",widgetStyle], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    labelWidgetStyle = widgetStyle;
    NSString *text = kUITextStyleEnumStr(widgetStyle);
    NSArray *array = [text componentsSeparatedByString:@"_"];
    NSAssert(array, @"error");
    NSArray *styles = [array subarrayWithRangeForMY:NSMakeRange(2, 3)];
    
    //    NSString *str = enumToString(style);
    CGFloat alpha = [[[styles lastObject]substringFromIndex:1]integerValue]/100.0;
    int rgb = kRGBFromKey([styles objectAtIndexForMY:0]);
    UIColor *color = kColorWithRGBA(rgb, alpha);
    UIFont *font;
    font = [theMYWidget performSelector:NSSelectorFromString([styles objectAtIndexForMY:1])];

    self.textColor = color;
    self.font = font;
}

- (void)setSizeWithSize:(CGSize)size {
    self.bounds = [self.text boundingRectWithSize:size
                            options:NSStringDrawingUsesLineFragmentOrigin
                         attributes:@{NSFontAttributeName:self.font}
                            context:nil];
}


@end
