//
//  MYSegmentLabel.m
//  xiaplay
//
//  Created by wmy on 15/12/11.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import "MYSegmentLabel.h"
#import <MYWidget/UILabel+MYStyle.h>

 
@implementation MYSegmentLabel

- (void)dealloc {
    
}

- (instancetype)init {
    if (self = [super init]) {
        self.chooseColor = theMYWidget.c0;
        self.defaultColor = theMYWidget.c1;
        self.widgetStyle = MYWidgetStyle_MYWidget_tt_c1_f3_a100;
        self.font = theMYWidget.f3;
        self.textColor = self.defaultColor;
        self.textAlignment = NSTextAlignmentCenter;
        
    }
    return self;
}

- (void)refreshView {
    self.chooseColor = theMYWidget.c0;
    self.defaultColor = theMYWidget.c1;
    self.widgetStyle = MYWidgetStyle_MYWidget_tt_c1_f3_a100;
    self.textColor = self.defaultColor;
    self.isChoose = self.isChoose;
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self setSizeWithSize:CGSizeZero];
}

- (void)setIsChoose:(BOOL)isChoose {
    _isChoose = isChoose;
    self.textColor = isChoose ? self.chooseColor : self.defaultColor;
}

- (void)setScale:(CGFloat)scale {
    const CGFloat *chooseComponents = CGColorGetComponents(self.chooseColor.CGColor);
    const CGFloat *defaultComponents = CGColorGetComponents(self.defaultColor.CGColor);
    CGFloat red = (chooseComponents[0] - defaultComponents[0]) * scale + defaultComponents[0];
    CGFloat green = (chooseComponents[1] - defaultComponents[1]) * scale + defaultComponents[1];
    CGFloat blue = (chooseComponents[2] - defaultComponents[2]) * scale + defaultComponents[2];
    self.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1];
}

@end
