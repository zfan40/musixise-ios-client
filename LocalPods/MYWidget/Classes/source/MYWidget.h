//
//  MYWidget.h
//  Pods
//
//  Created by wmy on 16/1/28.
//
//

/**
 *  用于定义各种颜色、字体、透明度
 */

#import <Foundation/Foundation.h>
#import <MYUtils/MYBasicSingleton.h>
#import <MYUtils/UIView+MYAdditons.h>
#define theMYWidget [MYWidget sharedInstance]

#define enumToString(value) @ #value

#define kRGBFromKey(key) [theMYWidget rgbFromKey:key]
//    ([@{@"c0": @(0xF53172), @"c1": @(0x818FFF), @"c2": @(0xFFFFFF), @"c3": @(0x000000), @"c4": @(0xF93B3B)} \
        intValueForKey:key])

#define kColorWithRGBA(rgb, alpha) RGBA(((rgb & 0xFF0000) >> 16), ((rgb & 0xFF00) >> 8), ((rgb & 0x00FF) >> 0), alpha)

#define newInstanceUIImageView(name,_name) \
- (UIImageView *)name { \
if (!_name) { \
_name = [[UIImageView alloc] init]; \
} \
return _name; \
}

#define newInstanceUIImageView1(name) \
- (UIImageView *)name { \
if (!_##name) { \
_##name = [[UIImageView alloc] init]; \
} \
return _##name; \
}

#define newInstanceUIView(name,_name) \
- (UIView *)name { \
if (!_name) { \
_name = [[UIView alloc] init]; \
} \
return _name; \
}

#define newInstanceUIView1(name) \
- (UIView *)name { \
if (!_##name) { \
_##name = [[UIView alloc] init]; \
} \
return _##name; \
}

#define newInstanceStyleUIButton(name,text,style) \
- (UIButton *)name { \
if (!_##name) { \
_##name = [UIButton buttonWithMYStyle:style title:text]; \
} \
return _##name; \
}

#define newInstanceUIButton(name, _name) \
- (UIButton *)name { \
if (!_name) { \
_name = [UIButton buttonWithType:UIButtonTypeCustom]; \
} \
return _name; \
}
#define newInstanceUIButton1(name) \
- (UIButton *)name { \
if (!_##name) { \
_##name = [UIButton buttonWithType:UIButtonTypeCustom]; \
} \
return _##name; \
}

#define newInstanceUILabel(name,_name,style) \
- (UILabel *)name { \
if (!_name) { \
_name = [UILabel labelWithStyle:style withTextAligment:NSTextAlignmentLeft]; \
} \
return _name; \
} \

#define newInstanceUILabel1(name,style) \
- (UILabel *)name { \
if (!_##name) { \
_##name = [UILabel labelWithStyle:style withTextAligment:NSTextAlignmentLeft]; \
} \
return _##name; \
} \

typedef enum {
    MYWidgetStyle_MYWidget_tt_c0_f1_a100 = 1,
    MYWidgetStyle_MYWidget_tt_c0_f2_a100,
    MYWidgetStyle_MYWidget_tt_c0_f3_a100,
    MYWidgetStyle_MYWidget_tt_c0_f4_a100,
    MYWidgetStyle_MYWidget_tt_c1_f2_a100,
    MYWidgetStyle_MYWidget_tt_c1_f3_a100,
    MYWidgetStyle_MYWidget_tt_c2_f1_a20,
    MYWidgetStyle_MYWidget_tt_c2_f1_a80,
    MYWidgetStyle_MYWidget_tt_c2_f2_a20,
    MYWidgetStyle_MYWidget_tt_c2_f2_a50,
    MYWidgetStyle_MYWidget_tt_c2_f2_a80,
    MYWidgetStyle_MYWidget_tt_c2_f3_a20,
    MYWidgetStyle_MYWidget_tt_c2_f3_a50,
    MYWidgetStyle_MYWidget_tt_c2_f3_a80,
    MYWidgetStyle_MYWidget_tt_c2_f4_a20,
    MYWidgetStyle_MYWidget_tt_c2_f4_a80,
    MYWidgetStyle_MYWidget_tt_c2_f4_a100,
    MYWidgetStyle_MYWidget_tt_c2_f5_a80,
} MYWidgetStyle;

#define kUITextStyleEnumStr(x)                   \
    ([@[                                         \
        @"MYWidgetStyle_MYWidget_tt_c0_f1_a100", \
        @"MYWidgetStyle_MYWidget_tt_c0_f2_a100", \
        @"MYWidgetStyle_tt_c0_f2_a100",          \
        @"MYWidgetStyle_tt_c0_f3_a100",          \
        @"MYWidgetStyle_tt_c0_f4_a100",          \
        @"MYWidgetStyle_tt_c1_f2_a100",          \
        @"MYWidgetStyle_tt_c1_f3_a100",          \
        @"MYWidgetStyle_tt_c2_f1_a20",           \
        @"MYWidgetStyle_tt_c2_f1_a80",           \
        @"MYWidgetStyle_tt_c2_f2_a20",           \
        @"MYWidgetStyle_tt_c2_f2_a50",           \
        @"MYWidgetStyle_tt_c2_f2_a80",           \
        @"MYWidgetStyle_tt_c2_f3_a20",           \
        @"MYWidgetStyle_tt_c2_f3_a50",           \
        @"MYWidgetStyle_tt_c2_f3_a80",           \
        @"MYWidgetStyle_tt_c2_f4_a20",           \
        @"MYWidgetStyle_tt_c2_f4_a50",           \
        @"MYWidgetStyle_tt_c2_f4_a80",           \
        @"MYWidgetStyle_tt_c2_f5_a80"            \
    ] objectAtIndexForALM:x])

@interface MYWidget : MYBasicSingleton

// ---------------------------------- 字体 begin --------------------------------------

/**
 *  底部条文字颜色 10dp
 */
@property (nonatomic, strong, readonly) UIFont *f1;
/**
 *  副标题 小标题 12dp
 */
@property (nonatomic, strong, readonly) UIFont *f2;
/**
 *  主标题 14dp
 */
@property (nonatomic, strong, readonly) UIFont *f3;
/**
 *  大标题 16dp
 */
@property (nonatomic, strong, readonly) UIFont *f4;
/**
 *  顶部条主要文字 18dp
 */
@property (nonatomic, strong, readonly) UIFont *f5;
/**
 *  大文字 20dp
 */
@property (nonatomic, strong, readonly) UIFont *f6;
/**
 *  超大文字 24dp
 */
@property (nonatomic, strong, readonly) UIFont *f7;

// ----------------------------------- 字体 end ---------------------------------------

// ---------------------------------- 颜色 begin --------------------------------------

/**
 *  品牌色
 */
@property (nonatomic, strong, readonly) UIColor *c0;
@property (nonatomic, strong, readonly) UIColor *c0_a20;
@property (nonatomic, strong, readonly) UIColor *c0_a50;
@property (nonatomic, strong, readonly) UIColor *c0_a80;
/**
 *  强调色
 */
@property (nonatomic, strong, readonly) UIColor *c1;
@property (nonatomic, strong, readonly) UIColor *c1_a20;
@property (nonatomic, strong, readonly) UIColor *c1_a6;
@property (nonatomic, strong, readonly) UIColor *c1_a50;

/**
 *  正文色
 */
@property (nonatomic, strong, readonly) UIColor *c2;
@property (nonatomic, strong, readonly) UIColor *c2_a6;
@property (nonatomic, strong, readonly) UIColor *c2_a20;
@property (nonatomic, strong, readonly) UIColor *c2_a50;
@property (nonatomic, strong, readonly) UIColor *c2_a80;

/**
 *  蒙版色
 */
@property (nonatomic, strong, readonly) UIColor *c3;
/**
 *  错误提示色
 */
@property (nonatomic, strong, readonly) UIColor *c4;
/**
 *  弹窗背景色
 */
@property (nonatomic, strong, readonly) UIColor *c5;
/**
 *  底部条背景色
 */
@property (nonatomic, strong, readonly) UIColor *c6;

// ----------------------------------- 颜色 end ---------------------------------------
/**
 *  cell的背景颜色
 */
@property (nonatomic, strong, readonly) UIColor *itemViewColor;
@property (nonatomic, strong, readonly) UIColor *seperatorColor;
@property (nonatomic, strong, readonly) UIColor *maskColor;
@property (nonatomic, strong, readonly) UIColor *backgroundColor;

@property (nonatomic, assign) CGFloat seperatorHeight;


// ---------------------------------- 间距 begin --------------------------------------

@property (nonatomic,assign, readonly) CGFloat m1;
@property (nonatomic,assign, readonly) CGFloat m2;
@property (nonatomic,assign, readonly) CGFloat m3;
@property (nonatomic,assign, readonly) CGFloat m4;
@property (nonatomic,assign, readonly) CGFloat m5;
// ----------------------------------- 间距 end ---------------------------------------


@property (nonatomic,strong) NSString *currentStyle;

- (NSArray<NSString *> *)skins;
- (void)setup;
- (int)rgbFromKey:(NSString *)key;

@end
