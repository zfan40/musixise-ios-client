//
//  MYAlertTitleView.h
//  Pods
//
//  Created by wmy on 16/1/30.
//
//  只有title的ALertView

#import <UIKit/UIKit.h>

@protocol MYAlertTitleViewDelegate <NSObject>

- (void)alertTitleViewDidClickCancel;
- (void)alertTitleViewDidClickOther;

@end

@interface MYAlertTitleView : UIView

@property (nonatomic,weak) id <MYAlertTitleViewDelegate> delegate;

+ (MYAlertTitleView *)alertTitleViewWithTitle:(NSString *)title
                                       cancel:(NSString *)cancel
                              otherButtonText:(NSString *)other
                             clickButtonBlock:(void(^)(int buttonIndex))buttonBlock;

@end
