//
//  MYAlertView.m
//  Pods
//
//  Created by wmy on 16/1/29.
//
//

#import "MYAlertView.h"
#import "MYWidget.h"
#import "UILabel+MYStyle.h"
#import "MYAlertInputView.h"
#import "MYAlertMessageView.h"
#import "MYAlertTitleView.h"
#import "MYAlertCheckboxView.h"
#import "MYAlertSingleChooseView.h"
#import <MYUtils/UIView+MYAdditons.h>
#import "UIView+MYCurrentViewController.h"
#import <MYUtils/MYDubugLog.h>

typedef enum {
    MYAlertViewType_Fade,
    MYAlertViewType_Move,
} MYAlertViewType;

@interface MYAlertView () <MYAlertInputViewDelegate,MYAlertTitleViewDelegate,MYAlertCheckboxViewDelegate,MYAlertSingleChooseViewDelegate>

/**
 *  指向需要显示的view
 */
@property (nonatomic, weak) UIView *subView;
@property (nonatomic,assign) MYAlertViewType type;

@end

@implementation MYAlertView

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (instancetype)init {
    if (self = [super init]) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.width = kScreenWidth;
    self.height = kScreenHeight;
    self.backgroundColor = theMYWidget.maskColor;
    
    UITapGestureRecognizer *alertBackTap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                  action:@selector(onClickBackground)];
    [self addGestureRecognizer:alertBackTap];
}



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
                           onClickButtonBlock:(clickBlock)buttonBlock {
    
    MYAlertView *alertView = [[MYAlertView alloc] init];
    alertView.type = MYAlertViewType_Fade;
    MYAlertInputView *alertInputView = [MYAlertInputView alertInputViewWithTitle:title
                                                                       placeable:placeabel
                                                                          lenght:length
                                                                       cancelStr:cannel
                                                                     otherButton:other
                                                                      clickBlock:buttonBlock];
    alertView.subView = alertInputView;
    alertInputView.delegate = alertView;
    [alertView showAlertView];
    return alertView;
}

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
                                         cancel:(NSString *)cancel {
    MYAlertView *alertView = [[MYAlertView alloc] init];
    alertView.type = MYAlertViewType_Fade;
    MYAlertMessageView *messageView = [MYAlertMessageView alertMessageViewWithTitle:title
                                                                            message:message
                                                                             cancel:cancel
                                                                        cancelBlock:^{
                                                                            [alertView cancelAlertView];
                                                                            
                                                                        }];
    alertView.subView = messageView;
    [alertView showAlertView];
    return alertView;
}

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
                          onClickButtonBlock:(void(^)(int buttonIndex))buttonBlock {
    MYAlertView *alertView = [[MYAlertView alloc] init];
    alertView.type = MYAlertViewType_Fade;
    MYAlertTitleView *alertTitleView = [MYAlertTitleView alertTitleViewWithTitle:title
                                                                          cancel:cancel
                                                                 otherButtonText:other
                                                                clickButtonBlock:buttonBlock];
    alertView.subView = alertTitleView;
    alertTitleView.delegate = alertView;
    [alertView showAlertView];
    return alertView;
}


+ (MYAlertView *)alertViewWithCheckboxModeTitle:(NSString *)title
                                        message:(NSString *)message
                                   checkboxText:(NSString *)checkboxText
                                         cancel:(NSString *)cancel
                                          other:(NSString *)other
                             onClickButtonBlock:(void(^)(int buttonIndex,BOOL isSelect))buttonBlock {
    MYAlertView *alertView = [[MYAlertView alloc] init];
    alertView.type = MYAlertViewType_Fade;
    MYAlertCheckboxView *checkboxView = [MYAlertCheckboxView alertCheckboxViewWith:title
                                                                       messageText:message
                                                                         checkText:checkboxText
                                                                        cancelText:cancel
                                                                         otherText:other
                                                                  clickButtonBlock:buttonBlock];
    alertView.subView = checkboxView;
    checkboxView.delegate = alertView;
    [alertView showAlertView];
    return alertView;
}


+ (MYAlertView *)alertViewWithSingleChooseWithTitle:(NSString *)title
                                        chooseArray:(NSArray <NSString *>*)array
                                      selectedIndex:(NSUInteger)index
                                      completeBlock:(void(^)(NSUInteger buttonIndex,BOOL isSelect))buttonBlock
                                         closeBlock:(void(^)())closeBlock {
    MYAlertView *alertView = [[MYAlertView alloc] init];
    alertView.type = MYAlertViewType_Move;
    MYAlertSingleChooseView *singleChooseView = [MYAlertSingleChooseView AlertSingleChooseViewWithTitle:title
                                                                                            chooseArray:array
                                                                                          selectedIndex:index
                                                                                          completeBlock:buttonBlock
                                                                                             closeBlock:closeBlock];
    alertView.subView = singleChooseView;
    singleChooseView.delegate = alertView;
    [alertView showAlertView];
    return alertView;
    
}


#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
}

#pragma mark - --------------------功能函数------------------

- (void)showAlertView {
    switch (self.type) {
        case MYAlertViewType_Fade:
        {
            self.alpha = 0;
            self.subView.alpha = 0;
            self.subView.centerX = self.width * 0.5;
            self.subView.centerY = self.height * 0.5;
            [[self getCurrentVC].view addSubview:self];
            [UIView animateWithDuration:0.5 animations:^{
                self.alpha = 1;
                self.subView.alpha = 1;
            }];
        }
            break;
        case MYAlertViewType_Move:
        {
            self.subView.top = self.bottom;
            self.alpha = 0;
            [[self getCurrentVC].view addSubview:self];
            [UIView animateWithDuration:0.5 animations:^{
                self.subView.bottom = self.height;
                self.alpha = 1;
            }];
        }
            
        default:
            break;
    }
}

- (void)cancelAlertView {
    switch (self.type) {
        case MYAlertViewType_Move:
        {
            [UIView animateWithDuration:0.5 animations:^{
                self.subView.top = self.bottom;
                self.alpha = 0;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        }
            break;
        case MYAlertViewType_Fade:
        {
            self.subView.alpha = 1;
            [UIView animateWithDuration:0.5 animations:^{
                self.alpha = 0;
                self.subView.alpha = 0;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
            
        }
            break;
    }
}

#pragma mark - --------------------手势事件------------------

- (void)onClickSubView {
    DebugLog(@"什么也不做");
}

- (void)onClickBackground {
    switch (self.type) {
        case MYAlertViewType_Move:
        {
            [UIView animateWithDuration:0.5 animations:^{
                self.alpha = 0;
                self.subView.top = self.bottom;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        }
            break;
        case MYAlertViewType_Fade:
        {
            [UIView animateWithDuration:0.5 animations:^{
                self.alpha = 0;
                self.subView.alpha = 0;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        }
            break;
    }
    
}

#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------

#pragma mark MYAlertSingleChooseViewDelegate

- (void)alertSingleChooseViewDidClickClose {
    [self cancelAlertView];
}

#pragma mark MYAlertInputViewDelegate

- (void)alertInputViewDidClickOther {
    [self cancelAlertView];
}

- (void)alertInputViewDidClickCancel {
    [self cancelAlertView];
}

#pragma mark MYAlertTitleViewDelegate

- (void)alertTitleViewDidClickOther {
    [self cancelAlertView];
}

- (void)alertTitleViewDidClickCancel {
    [self cancelAlertView];
}

#pragma mark MYAlertCheckboxViewDelegate

- (void)alertCheckboxViewDidClickOther {
    [self cancelAlertView];
}

- (void)alertCheckboxViewDidClickCancel {
    [self cancelAlertView];
}


#pragma mark - --------------------属性相关------------------

- (void)setSubView:(UIView *)subView {
    _subView = subView;
    [self addSubview:subView];
    subView.userInteractionEnabled = YES;
    subView.backgroundColor = theMYWidget.backgroundColor;
    
    UITapGestureRecognizer *subTap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                              action:@selector(onClickSubView)];
    [subView addGestureRecognizer:subTap];
}

@end
