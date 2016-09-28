//
//  UIView+MYCurrentViewController.h
//  Pods
//
//  Created by wmy on 16/2/2.
//
//

#import <UIKit/UIKit.h>

@interface UIView (MYCurrentViewController)

/**
 *  获取到当前正在显示viewController
 *
 *  @return viewcontroller
 */
- (UIViewController *)getCurrentVC;

@end
