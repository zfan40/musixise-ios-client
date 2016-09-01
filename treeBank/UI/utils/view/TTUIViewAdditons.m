//
//  TTUIViewAdditons.m
//  xiamiHD
//
//  Created by kebi on 16-3-24.
//  Copyright 2016年 __MyCompanyName__. All rights reserved.
//

#import "TTUIViewAdditons.h"
//#import "UIDevice+platformType.h"
@implementation UIView (xiamiUIView)

-(CGFloat)left {
    return self.frame.origin.x;
}
-(void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

-(CGFloat)top {
    return self.frame.origin.y;
}
-(void)setTop:(CGFloat)top {
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

-(CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}
-(void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

-(CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}
-(void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

-(CGFloat)centerX {
    return self.center.x;
}
-(void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}
- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)width {
    return self.frame.size.width;
}
- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}
- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

-(CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}
-(void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds=YES;
}
-(CGFloat)borderWidth {
    return self.layer.borderWidth;
}
-(void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}
-(UIColor*)borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}
-(void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}
-(UIColor *)shadowColor {
    return [UIColor colorWithCGColor:self.layer.shadowColor];
}
-(void)setShadowColor:(UIColor *)shadowColor {
    self.layer.shadowOpacity=0.5;
    self.layer.shadowColor = [shadowColor CGColor];
}
-(CGSize)shadowOffset {
    return self.layer.shadowOffset;
}
-(void)setShadowOffset:(CGSize)shadowOffset {
    self.layer.shadowOffset = shadowOffset;
}

//add by lijianfeng
-(CGSize)size{
  return   self.frame.size;
}
-(void)setSize:(CGSize)size{
    CGPoint center = self.center;
    CGRect frame = self.frame;
    frame.size =size;
    self.frame =frame;
    self.center =center;
}
#pragma mark action--
//- (void)removeAllSubViews {
//    while (self.subviews.count) {
//        UIView* child = self.subviews.lastObject;
//        [child removeFromSuperview];
//    }
//}
//-(void)closeKeyboard {
//    if ([self isFirstResponder]) {
//        [self resignFirstResponder];
//        return;
//    }
//
//    for (UIView * v in [self subviews]) {
//        if ([v isFirstResponder]) {
//            [v resignFirstResponder];
//            return;
//        }
//    }
//}

//-(UIView *)setBadgeValue:(NSString *)value {
//    CustomBadge * badgeView = nil;
//    for (UIView * v in self.subviews) {
//        if ([v isKindOfClass:[CustomBadge class]] && 999 == v.tag) {
//            badgeView = (CustomBadge *)v;
//            break;
//        }
//    }
//
//    if (!badgeView && !isEmptyString(value)) {
//        badgeView = [CustomBadge customBadgeWithString:value];
//        [badgeView setBadgeFrame:NO];
//        //[badgeView setBadgeShining:NO];
//        [self addSubview:badgeView];
//        [badgeView setTag:999];
//    }else {
//        if(isEmptyString(value))
//        {
//            [badgeView removeFromSuperview];
//            badgeView=nil;
//        }
//        else
//        {
//            [badgeView autoBadgeSizeWithString:value];
//        }
//    }
//    return badgeView;
//}
//-(UIActivityIndicatorView *) addActiveView
//{
//    UIActivityIndicatorView * active=nil;
//    for (UIView * v in self.subviews) {
//        if ([v isKindOfClass:[UIActivityIndicatorView class]] && 1111 == v.tag) {
//            active =(UIActivityIndicatorView*)v;
//
//            return active;
//        }
//    }
//    active=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    active.center=CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
//    [active setHidesWhenStopped:YES];
//    active.tag=1111;
//    [self addSubview:active];
//    return active;
//}
//-(UIActivityIndicatorView *) addLeftActiveView
//{
//    UIActivityIndicatorView * active=nil;
//    for (UIView * v in self.subviews) {
//        if ([v isKindOfClass:[UIActivityIndicatorView class]] && 1111 == v.tag) {
//            active =(UIActivityIndicatorView*)v;
//
//            return active;
//        }
//    }
//    active=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    active.center=CGPointMake(self.bounds.size.width/4, self.bounds.size.height/2);
//    [active setHidesWhenStopped:YES];
//    active.tag=1111;
//    [self addSubview:active];
//    return active;
//}
-(void)setBackgroundImage:(UIImage *)img {
    [self.layer setContents:(id)[img CGImage]];
}
+(CGFloat)screenHeight{
   return [[UIScreen mainScreen]bounds].size.height;
}
+(CGFloat)screenWidth{
    return [[UIScreen mainScreen]bounds].size.width;
}
@end
