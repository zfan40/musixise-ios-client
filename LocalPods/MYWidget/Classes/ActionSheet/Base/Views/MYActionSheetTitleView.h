//
//  MYActionSheetTitleView.h
//  Pods
//
//  Created by wmy on 2017/4/5.
//
//

#import <UIKit/UIKit.h>
#import "MYActionSheetDelegate.h"

@interface MYActionSheetTitleView : UIView <MYActionSheetTitleViewProtocol>

/**
 ActionSheet的头部View

 @param title title
 @param subTitle subTitle
 @return view，此时的View是一个没有长宽的View，需要外部来设置
 */
+ (instancetype)actionSheetWithTitle:(NSString *)title andSubTitle:(NSString *)subTitle;

@end
