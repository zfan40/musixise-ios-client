//
//  UIView+DeviceOrientationChanged.m
//  TTPod
//
//  Created by chaoyang.zhang on 13-10-28.
//
//

#import "UIView+DeviceOrientationChanged.h"

@implementation UIView (DeviceOrientationChanged)

- (void)transformViewByCurrentOrientation
{
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    if ([[UIDevice currentDevice].systemVersion floatValue]>=8.0) {
        interfaceOrientation = UIInterfaceOrientationPortrait;
    }
    CGFloat newAngle = [self angleFromOrientation:interfaceOrientation];
    self.transform = CGAffineTransformIdentity;
    self.transform = CGAffineTransformMakeRotation(newAngle);
}

- (void)transformViewWithOrientation:(UIInterfaceOrientation)orientation
{
    CGFloat newAngle = [self angleFromOrientation:orientation];
    self.transform = CGAffineTransformIdentity;
    self.transform = CGAffineTransformMakeRotation(newAngle);
}

- (CGFloat)angleFromOrientation:(UIInterfaceOrientation)orientation
{
    CGFloat currentAngle = 0.0f;
    switch (orientation) {
        case UIInterfaceOrientationPortrait:
            currentAngle = 0.0f;
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            currentAngle = M_PI;
            break;
        case UIInterfaceOrientationLandscapeRight:
            currentAngle = M_PI_2;
            break;
        case UIInterfaceOrientationLandscapeLeft:
            currentAngle = - M_PI_2;
        default:
            break;
    }
    return currentAngle;
}

@end
