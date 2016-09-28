//
//  UIView+Additons.m
//  TTUtilities
//
//  Created by OSang on 15/10/16.
//  Copyright © 2015年 TTPod. All rights reserved.
//

#import "UIView+MYAdditons.h"

@implementation UIView (MYAdditons)

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds=YES;
}

- (CGFloat)borderWidth
{
    return self.layer.borderWidth;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
}

- (UIColor*)borderColor
{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)shadowColor
{
    return [UIColor colorWithCGColor:self.layer.shadowColor];
}

- (void)setShadowColor:(UIColor *)shadowColor
{
    self.layer.shadowOpacity=0.5;
    self.layer.shadowColor = [shadowColor CGColor];
}

- (CGSize)shadowOffset
{
    return self.layer.shadowOffset;
}

-(void)setShadowOffset:(CGSize)shadowOffset {
    self.layer.shadowOffset = shadowOffset;
}

- (CGSize)size
{
    return   self.frame.size;
}

- (void)setSize:(CGSize)size
{
    CGPoint center = self.center;
    CGRect frame = self.frame;
    frame.size =size;
    self.frame =frame;
    self.center =center;
}

- (void)setBackgroundImage:(UIImage *)img
{
    [self.layer setContents:(id)[img CGImage]];
}

+ (CGFloat)screenHeight
{
    static CGFloat height = 0;
    
    if (height ==0) {
        height =[[UIScreen mainScreen]bounds].size.height;
    }
    
    return height;
}

+ (CGFloat)screenWidth
{
    static CGFloat width = 0;
    
    if (width ==0 ) {
        width =[[UIScreen mainScreen]bounds].size.width ;
    }
    
    return width;
}

- (CGRect)frameWithLabel{
    if ([self isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)self;
        CGSize size = [label.text boundingRectWithSize:label.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil].size;
        CGFloat top = label.top;
        CGFloat left = label.left;
        return CGRectMake(left, top, size.width, size.height);
    }else {
        return CGRectZero;
    }
}

@end
