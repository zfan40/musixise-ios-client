//
//  UITextView+MYStyle.m
//  Pods
//
//  Created by wmy on 16/1/29.
//
//

#import "UITextView+MYStyle.h"
#import <objc/runtime.h>
#import <MYUtils/NSArray+ALMSafe.h>
#import <MYUtils/NSDictionary+ALMSafe.h>

static char charTextViewStyle;
static const void *innerStyle = &innerStyle;

@implementation UITextView (MYStyle)
@dynamic textViewStyle;

- (void)dealloc {
    
}

+ (UITextView *)textViewWithWidgetStyle:(MYWidgetStyle)style {
    UITextView *textView = [[UITextView alloc] init];
    textView.textViewStyle = style;
    return textView;
}

- (void)onChangeSkin {
    
    [self setTextViewStyle:charTextViewStyle];
}

- (MYWidgetStyle)textViewStyle {
    NSString *keyValue = objc_getAssociatedObject(self, innerStyle);
    unsigned long enumValue = keyValue.longLongValue;
    [self setTextViewStyle:(MYWidgetStyle)enumValue];
    return (MYWidgetStyle)enumValue;
}

- (void)setTextViewStyle:(MYWidgetStyle)textViewStyle {
    charTextViewStyle = textViewStyle;
    objc_setAssociatedObject(self, innerStyle, [NSString stringWithFormat:@"%d",textViewStyle], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    NSString *text = kUITextStyleEnumStr(textViewStyle);
    NSArray *array = [text componentsSeparatedByString:@"_"];
    NSAssert(array, @"error");
    NSArray *styles = [array subarrayWithRangeForALM:NSMakeRange(2, 3)];

    CGFloat alpha = [[[styles lastObject]substringFromIndex:1]integerValue]/100.0;
    int rgb = kRGBFromKey([styles objectAtIndexForALM:0]);
    UIColor *color = kColorWithRGBA(rgb, alpha);
    UIFont *font;
    font = [theMYWidget performSelector:NSSelectorFromString([styles objectAtIndexForALM:1])];
    
    self.textColor = color;
    self.font = font;
}

@end
