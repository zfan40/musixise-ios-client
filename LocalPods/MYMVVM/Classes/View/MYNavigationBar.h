//
//  MYNavigationBar.h
//  Pods
//
//  Created by wmy on 16/9/28.
//
//

#import <UIKit/UIKit.h>

@interface MYNavigationBar : UIView

- (void)setTitle:(NSString *)title;
- (void)addSubViewToLeft:(UIView *)view;
- (void)addSubViewToRight:(UIView *)view;

@end
