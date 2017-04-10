//
//  MYActionSheet.h
//  Pods
//
//  Created by wmy on 2017/3/16.
//
//  弹出窗口

#import <UIKit/UIKit.h>
#import "MYActionSheetDelegate.h"

@interface MYActionSheet : UIView


/**
 创建一个ActionSheet

 @param title 标题
 @param message 内容
 @param delegate 代理
 @param cancelTitle 取消按钮标题
 @param models 中间部分选项
 @return actionSheet
 */
+ (instancetype)actionSheetWithTitle:(NSString *)title
                             message:(NSString *)message
                            delegate:(id<MYActionSheetDelegate>)delegate
                   cancelButtonTitle:(NSString *)cancelTitle
                     titleModelArray:(NSArray<id<MYActionSheetItemModelProtocol>> *)models;

/**
 创建一个有多个button的ActionSheet

 @param title 标题
 @param message 内容
 @param delegate 代理
 @param buttonTitleArray button按钮标题
 @param cancelButtonTitle 取消按钮标题
 @return actionSheet
 */
+ (instancetype)actionSheetWithTitle:(NSString *)title
                             message:(NSString *)message
                            delegate:(id<MYActionSheetDelegate>)delegate
                   cancelButtonTitle:(NSString *)cancelButtonTitle
                    buttonTitleArray:(NSArray<NSString *> *)buttonTitleArray;


/**
 创建一个内容为自定义的ActionSheet

 @param title 标题
 @param customView 自定义View
 @param delegate 代理
 @param cancelTitle 取消按钮标题
 @param destructiveTitle 确定按钮标题
 @return actionSheet
 */
+ (instancetype)actionSheetWithTitle:(NSString *)title
                            subTitle:(NSString *)subTitle
                          customView:(UIView *)customView
                            delegate:(id<MYActionSheetDelegate>)delegate
                   cancelButtonTitle:(NSString *)cancelTitle;

/**
 创建一个自定义的actionSheet

 @param customView 自定义View
 @return actionSheet
 */
+ (instancetype)actionSheetWithView:(UIView *)customView
                           delegate:(id<MYActionSheetDelegate>)delegate;


/**
 自定义customView

 @param customViewController ViewController
 @param delegate 代理
 @return actionSheet
 */
+ (instancetype)actionSheetWithViewController:(UIViewController *)customViewController
                                     delegate:(id<MYActionSheetDelegate>)delegate;

- (void)show;
- (void)dismiss;

@end
