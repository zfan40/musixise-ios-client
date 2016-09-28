//
//  UIView+Additons.h
//  TTUtilities
//
//  Created by OSang on 15/10/16.
//  Copyright © 2015年 TTPod. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGBA(r,g,b,a)           [UIColor colorWithRed:((float)r)/255.f green:((float)g)/255.f blue:((float)b)/255.f alpha:a]
#define RGB(r,g,b)              RGBA(r,g,b,1.0f)
#define ColorWithHex(hexValue)  RGBA( ((hexValue & 0xFF000000) >> 24), ((hexValue & 0xFF0000) >> 16), ((hexValue & 0xFF00) >> 8), ((float)(hexValue & 0x00FF))/255.f )

#define kScreenWidth  [UIView screenWidth]
#define kScreenHeight  [UIView screenHeight]

/**
 *  UIView的辅助类，方便快捷地访问使用UIView中的各种属性，减少冗余代码量
 */
@interface UIView (MYAdditons)

@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) CGSize shadowOffset;
@property (nonatomic, strong) UIColor *shadowColor;
@property (nonatomic, assign) CGSize size;

- (void)setBackgroundImage:(UIImage *)img;
+ (CGFloat)screenHeight;
+ (CGFloat)screenWidth;
- (CGRect)frameWithLabel;

@end
