//
//  MYAlertCheckboxView.h
//  Pods
//
//  Created by wmy on 16/2/2.
//
//

#import <UIKit/UIKit.h>


@protocol MYAlertCheckboxViewDelegate <NSObject>

- (void)alertCheckboxViewDidClickCancel;
- (void)alertCheckboxViewDidClickOther;

@end

@interface MYAlertCheckboxView : UIView



@property (nonatomic,weak) id<MYAlertCheckboxViewDelegate> delegate;

/**
*  创建带有checkbox的对话框
*
*  @param title       标题
*  @param message     内容
*  @param checkText   checkBox的内容
*  @param cancelText  左侧按钮内容
*  @param otherText   右侧按钮内容
*  @param buttonBlock 点击button的回调
*
*  @return 带有checkbox的对话框
*/
+ (MYAlertCheckboxView *)alertCheckboxViewWith:(NSString *)title
                                   messageText:(NSString *)message
                                     checkText:(NSString *)checkText
                                    cancelText:(NSString *)cancelText
                                     otherText:(NSString *)otherText
                              clickButtonBlock:(void(^)(int buttonIndex,BOOL isSelect))buttonBlock;




@end
