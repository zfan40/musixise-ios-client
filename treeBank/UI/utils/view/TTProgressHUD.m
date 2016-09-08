//
//  TTProgressHUD.m
//  Pods
//
//  Created by xiewei on 16/3/4.
//
//

#import "TTProgressHUD.h"

@implementation TTProgressHUD

- (void)updateForCurrentOrientationAnimated:(BOOL)animated {
    // Stay in sync with the superview in any case
    CGAffineTransform rotationTransform;
    if (self.superview) {
        self.bounds = self.superview.bounds;
        self.bounds = CGRectMake(0, 0, 480, 320);
        [self setNeedsDisplay];
    }

// Not needed on iOS 8+, compile out when the deployment target allows,
// to avoid sharedApplication problems on extension targets
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 80000
    if (!self.isShowKeyBoard) {
        // Only needed pre iOS 7 when added to a window
        BOOL iOS8OrLater = kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_8_0;
        if (iOS8OrLater || ![self.superview isKindOfClass:[UIWindow class]])
            return;

        //	UIInterfaceOrientation orientation = [[UIDevice currentDevice] orientation];
        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
        CGFloat radians = 0;
        if (UIInterfaceOrientationIsLandscape(orientation)) {
            if (orientation == UIInterfaceOrientationLandscapeLeft) {
                radians = -(CGFloat)M_PI_2;
            } else {
                radians = (CGFloat)M_PI_2;
            }
            // Window coordinates differ!
            self.bounds = CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.width);
        } else {
            if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
                radians = (CGFloat)M_PI;
            } else {
                radians = 0;
            }
        }
        rotationTransform = CGAffineTransformMakeRotation(radians);

        if (animated) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.3];
        }
        [self setTransform:rotationTransform];
        if (animated) {
            [UIView commitAnimations];
        }
    }
#endif
}

@end
