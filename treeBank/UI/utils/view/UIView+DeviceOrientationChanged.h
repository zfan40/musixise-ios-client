//
//  UIView+DeviceOrientationChanged.h
//  TTPod
//
//  Created by chaoyang.zhang on 13-10-28.
//
//

#import <UIKit/UIKit.h>

/**
 *  UIView+DeviceOrientationChanged.h转换view到当前的Orientation。
 */

@interface UIView (DeviceOrientationChanged)

- (void)transformViewByCurrentOrientation;
- (void)transformViewWithOrientation:(UIInterfaceOrientation)orientation;
@end
