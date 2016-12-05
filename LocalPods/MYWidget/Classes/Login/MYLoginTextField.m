//
//  MYLoginTextField.m
//  Pods
//
//  Created by wmy on 16/9/29.
//
//

#import "MYLoginTextField.h"
#import "UITextField+MYStyle.h"

@implementation MYLoginTextField

+ (instancetype)loginTextFieldWithHint:(NSString *)hint {
    MYLoginTextField *textField = [[MYLoginTextField alloc] init];
    textField.width = kScreenWidth - theMYWidget.m5 * 2;
    textField.height = 50;
    textField.placeholder = hint;
    textField.backgroundColor = [UIColor whiteColor];
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    [attrDict setObject:theMYWidget.c5 forKey:NSForegroundColorAttributeName];
    [attrDict setObject:theMYWidget.f3 forKey:NSFontAttributeName];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:textField.placeholder attributes:attrDict];
    textField.attributedPlaceholder = attr;
    textField.textColor = theMYWidget.c2;
    textField.font = theMYWidget.f3;
    return textField;
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    return CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
}

- (void)drawPlaceholderInRect:(CGRect)rect {
    [super drawPlaceholderInRect:CGRectMake(theMYWidget.m3, 0, self.bounds.size.width, self.bounds.size.height)];
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, theMYWidget.m3, 0);
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, theMYWidget.m3, 0);
}

@end
