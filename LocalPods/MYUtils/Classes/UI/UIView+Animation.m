//
//  UIView+Animation.m
//  Pods
//
//  Created by wmy on 16/7/11.
//
//

#import "UIView+Animation.h"

@implementation UIView (Animation)


- (void)rotateAnimationWithAngle:(float)degree time:(float)time {
//    self.transform = CGAffineTransformMakeRotation(degree);
    [UIView beginAnimations:@"rotate" context:nil];
    [UIView setAnimationDuration:time];
    self.transform = CGAffineTransformMakeRotation(degree);
    [UIView commitAnimations];
}

@end
