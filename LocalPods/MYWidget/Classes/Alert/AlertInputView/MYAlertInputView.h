//
//  MYAlertInputView.h
//  Pods
//  带输入框的对话框
//  Created by wmy on 16/1/29.
//
//



#import <UIKit/UIKit.h>

@protocol MYAlertInputViewDelegate <NSObject>

- (void)alertInputViewDidClickCancel;
- (void)alertInputViewDidClickOther;

@end


typedef void(^clickBlock)(int index,NSUInteger length,NSString *text);
@interface MYAlertInputView : UIView

@property (nonatomic,weak) id<MYAlertInputViewDelegate> delegate;


/**
 *  创建带输入框的对话框
 *
 *  @param title            标题
 *  @param placeable        提示语
 *  @param length           输入框可输入的最大长度，为0时不限制长度
 *  @param cancel           取消按钮的string，不设置时默认为“取消”
 *  @param otherButtonTitle 右侧按钮的string，不设置时，默认为“确定”
 *  @param block            点击时的回调(当buttonIndex=0时，为点击取消按钮，buttonIndex=1时，为点击确定按钮)
 *
 *  @return 带输入框的对话框
 */
+ (MYAlertInputView *)alertInputViewWithTitle:(NSString *)title
                                    placeable:(NSString *)placeable
                                       lenght:(NSUInteger)length
                                    cancelStr:(NSString *)cancel
                                  otherButton:(NSString *)otherButtonTitle
                                   clickBlock:(clickBlock)block;



@end
