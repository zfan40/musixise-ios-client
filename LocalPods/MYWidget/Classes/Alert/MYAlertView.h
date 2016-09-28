//
//  MYAlertView.h
//  Pods
//
//  Created by wmy on 16/1/29.
//
//

#import <UIKit/UIKit.h>

@interface MYAlertView : UIView


/**
 *  带输入框的AlertView
 *
 *  @param title      标题
 *  @param placeabel  输入提示
 *  @param cannel     取消button
 *  @param titleArray 右侧的button
 *
 *  @return MyAlertView
 */
+ (MYAlertView *)alertViewWithInputModdeTitle:(NSString *)title
                               inputPlaceable:(NSString *)placeabel
                            cancelButtonTitle:(NSString *)cannel
                                       length:(int)length
                            otherButtonsTitle:(NSString *)other
                           onClickButtonBlock:(void (^)(int buttonIndex,int length,NSString *text))buttonBlock;

/**
 *  创建提示信息的AlertView
 *
 *  @param title   标题
 *  @param message 内容
 *  @param cancel  取消button
 *
 *  @return 带提示信息的AlertView
 */
+ (MYAlertView *)alertViewWithMessageModelTitle:(NSString *)title
                                        message:(NSString *)message
                                         cancel:(NSString *)cancel;

/**
 *  创建只有title的AlertView
 *
 *  @param title       标题
 *  @param cancel      取消button的提示
 *  @param other       右侧的buton
 *  @param buttonBlock 点击button的block
 *
 *  @return MYAlertView
 */
+ (MYAlertView *)alertViewWithTitleModeTitle:(NSString *)title
                                      cancel:(NSString *)cancel
                                 otherButton:(NSString *)other
                          onClickButtonBlock:(void(^)(int buttonIndex))buttonBlock;

/**
 *  创建有checkbox的AlertView
 *
 *  @param title        标题
 *  @param message      内容
 *  @param checkboxText checkbox右侧的提示
 *  @param cancel       左侧的button
 *  @param other        右侧的button
 *  @param buttonBlock  点击button的block
 *
 *  @return 有checkbox的AlertView
 */
+ (MYAlertView *)alertViewWithCheckboxModeTitle:(NSString *)title
                                        message:(NSString *)message
                                   checkboxText:(NSString *)checkboxText
                                         cancel:(NSString *)cancel
                                          other:(NSString *)other
                          onClickButtonBlock:(void(^)(int buttonIndex,BOOL isSelect))buttonBlock;


+ (MYAlertView *)alertViewWithSingleChooseWithTitle:(NSString *)title
                                        chooseArray:(NSArray <NSString *>*)array
                                      selectedIndex:(NSUInteger)index
                                      completeBlock:(void(^)(NSUInteger buttonIndex,BOOL isSelect))buttonBlock
                                         closeBlock:(void(^)())closeBlock;


@end
