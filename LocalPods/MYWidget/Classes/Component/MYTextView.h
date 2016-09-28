//
//  MYTextView.h
//  Pods
//
//  Created by wmy on 16/6/6.
//
//

#import <UIKit/UIKit.h>
#import "MYWidget.h"

@interface MYTextView : UIView

/**
 *  实例化组件
 *
 *  @param text 提示语
 *
 *  @return 组件
 */
+ (instancetype)textViewWithplaceText:(NSString *)text;


/**
 *  设置提示语
 *
 *  @param text 提示语
 */
- (void)setPlaceHolderText:(NSString *)text;
- (UITextView *)textView;
- (UILabel *)placeholderLabel;

@end
