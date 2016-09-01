//
//  TTUIViewAdditons.h
//  xiamiHD
//
//  Created by kebi on 16-3-24.
//  Copyright 2016年 __MyCompanyName__. All rights reserved.
//
#define TTkScreenWidth  [UIView screenWidth]
#define TTkScreenHeight  [UIView screenHeight]
#define TTTTkStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define TTTTScreen3P5Inch  ([[UIScreen mainScreen] currentMode].size.height <1136)
#import <UIKit/UIKit.h>

@interface UIView (xiamiUIView)
@property(nonatomic)CGFloat  left;
@property(nonatomic)CGFloat  right;
@property(nonatomic)CGFloat  top;
@property(nonatomic)CGFloat  bottom;
@property(nonatomic)CGFloat  width;
@property(nonatomic)CGFloat  height;
@property(nonatomic)CGFloat  centerX;
@property(nonatomic)CGFloat  centerY;
@property(nonatomic)CGFloat  cornerRadius;
@property(nonatomic)CGFloat  borderWidth;
@property(nonatomic,retain)UIColor* borderColor;
@property(nonatomic)CGSize shadowOffset;
@property(nonatomic,retain)UIColor* shadowColor;
//add by lijianfeng
@property(nonatomic,assign)CGSize size;
//-(UIActivityIndicatorView *) addLeftActiveView;
-(void)setBackgroundImage:(UIImage *)img;
+(CGFloat)screenHeight;
+(CGFloat)screenWidth;
@end
