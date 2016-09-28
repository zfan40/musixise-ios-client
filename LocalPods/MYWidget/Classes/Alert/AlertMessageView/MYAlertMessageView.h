//
//  MYAlertMessageView.h
//  Pods
//
//  Created by wmy on 16/1/30.
//
//

#import <UIKit/UIKit.h>

@interface MYAlertMessageView : UIView

/**
 *  创建有标题和内容的输入框
 *
 *  @param title       标题
 *  @param message     内容
 *  @param cancelBlock 点击取消时的block
 *
 *  @return 有标题和内容的输入框
 */
+ (MYAlertMessageView *)alertMessageViewWithTitle:(NSString *)title
                                          message:(NSString *)message
                                           cancel:(NSString *)cancel
                                      cancelBlock:(void(^)(void))cancelBlock;

@end
