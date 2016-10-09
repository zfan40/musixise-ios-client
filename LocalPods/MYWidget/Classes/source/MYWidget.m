//
//  MYWidget.m
//  Pods
//
//  Created by wmy on 16/1/28.
//
//

#import "MYWidget.h"
#import <MYUtils/UIView+MYAdditons.h>
#import <MYUtils/MYJSONUtil.h>
#import <MYUtils/MYDubugLog.h>
#import <MYUtils/MYUserDefaultUtil.h>
#import <MYUtils/MYSafeUtil.h>
#import <MYUtils/NSString+Convert.h>
@interface MYWidget ()

@property (nonatomic,strong) NSDictionary<NSString *,NSDictionary *> *colorDict;
@property (nonatomic,strong) NSDictionary *currentColorDict;

@end

@implementation MYWidget

- (NSArray<NSString *> *)skins {
    return [self.colorDict allKeys];
}

- (void)setup {
    self.currentStyle = [[MYUserDefaultUtil sharedInstance] stringDataForKey:@"skin"];
    if (isEmptyString(self.currentStyle)) {
        self.currentStyle = @"white";
    }
    InfoLog(@"皮肤初始化完毕");
}

- (NSDictionary<NSString *,NSDictionary *> *)colorDict {
    if (!_colorDict) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"skins" ofType:@"json"];
        NSDictionary *dict = [[MYJSONUtil sharedInstance] dictionaryWithJSONFilePath:filePath forKey:@""];
        _colorDict = dict;
    }
    return _colorDict;
}

- (void)setCurrentStyle:(NSString *)currentStyle {
    if ([[self.colorDict allKeys] containsObject:currentStyle]) {
        _currentStyle = currentStyle;
        [[MYUserDefaultUtil sharedInstance] safeStringData:currentStyle forKey:@"skin"];
        self.currentColorDict = [self.colorDict objectForKey:currentStyle];
    } else {
        WarnLog(@"设置的皮肤名不存在");
    }
}

- (int)rgbFromKey:(NSString *)key {
    NSString *value = [self.currentColorDict objectForKey:key];
    NSString *resultStr = [value substringToIndex:value.length - 2];
    return (int)[resultStr stringToHex];
}
// ---------------------------------- 字体 begin --------------------------------------


- (UIFont *)f1 {
    return [UIFont systemFontOfSize:10];
}

- (UIFont *)f2 {
    return [UIFont systemFontOfSize:12];
}

- (UIFont *)f3 {
    return [UIFont systemFontOfSize:14];
}

- (UIFont *)f4 {
    return [UIFont systemFontOfSize:16];
}

- (UIFont *)f5 {
    return [UIFont systemFontOfSize:18];
}

- (UIFont *)f6 {
    return [UIFont systemFontOfSize:20];
}

- (UIFont *)f7 {
    return [UIFont systemFontOfSize:24];
}

// ----------------------------------- 字体 end ---------------------------------------

// ---------------------------------- 颜色 begin --------------------------------------

- (UIColor *)c0 {
    return ColorWithHex([[self.currentColorDict objectForKey:@"c0"] stringToHex]);
}

- (UIColor *)c0_a20 {
    return [self.c0 colorWithAlphaComponent:0.2f];
}

- (UIColor *)c0_a50 {
    return [self.c0 colorWithAlphaComponent:0.5f];
}

- (UIColor *)c0_a80 {
    return [self.c0 colorWithAlphaComponent:0.8f];
}

- (UIColor *)c1 {
    ;
    return ColorWithHex([[self.currentColorDict objectForKey:@"c1"] stringToHex]);
}

- (UIColor *)c1_a20 {
    return [self.c1 colorWithAlphaComponent:0.2f];
}

- (UIColor *)c2 {
    return ColorWithHex([[self.currentColorDict objectForKey:@"c2"] stringToHex]);
}

- (UIColor *)c2_a80 {
    return [self.c2 colorWithAlphaComponent:0.8f];

}

- (UIColor *)c2_a50 {
    return [self.c2 colorWithAlphaComponent:0.5];
    
}

- (UIColor *)c2_a20 {
    return [self.c2 colorWithAlphaComponent:0.2f];
}

- (UIColor *)c2_a6 {
    return [self.c2 colorWithAlphaComponent:0.06f];
}

- (UIColor *)c3 {
    return ColorWithHex([[self.currentColorDict objectForKey:@"c3"] stringToHex]);
}

- (UIColor *)c4 {
    return ColorWithHex([[self.currentColorDict objectForKey:@"c4"] stringToHex]);
}

- (UIColor *)c5 {
    return ColorWithHex([[self.currentColorDict objectForKey:@"c5"] stringToHex]);
}

- (UIColor *)c6 {
    return ColorWithHex([[self.currentColorDict objectForKey:@"c6"] stringToHex]);
}

// ----------------------------------- 颜色 end ---------------------------------------

- (UIColor *)itemViewColor {
    return ColorWithHex([[self.currentColorDict objectForKey:@"itemViewColor"] stringToHex]);
}

- (UIColor *)seperatorColor {
    return ColorWithHex([[self.currentColorDict objectForKey:@"seperatorColor"] stringToHex]);
}

- (UIColor *)maskColor {
    return ColorWithHex([[self.currentColorDict objectForKey:@"maskColor"] stringToHex]);
}

- (UIColor *)backgroundColor {
    UIColor *color = ColorWithHex([[self.currentColorDict objectForKey:@"backgroundColor"] stringToHex]);
    return color;
}

- (CGFloat)seperatorHeight {
    return 0.5;
}


// ---------------------------------- 间距 begin --------------------------------------


- (CGFloat)m1 {
    return 0;
}

- (CGFloat)m2 {
    return 5;
}

- (CGFloat)m3 {
    return 10;
}

- (CGFloat)m4 {
    return 15;
}

- (CGFloat)m5 {
    return 20;
}

// ----------------------------------- 间距 end ---------------------------------------



@end
