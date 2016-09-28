//
//  MYTipsHelper.m
//  Pods
//
//  Created by wmy on 16/2/2.
//
//

#import "MYTipsHelper.h"
#import "MYTipsView.h"
#import "UIView+MYAdditons.h"
#import "UIView+MYCurrentViewController.h"
#import "MYTopView.h"

@interface MYTipsHelper ()

@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, strong) MYTipsView *tipsView;

@end

@implementation MYTipsHelper {
    BOOL _isShow;
}

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------
#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------
#pragma mark - --------------------功能函数------------------

- (void)showTips:(NSString *)text {
    if (self.isShow) {
        [NSRunLoop cancelPreviousPerformRequestsWithTarget:self];
        [UIView animateWithDuration:0.25
            animations:^{
                self.tipsView.alpha = 0;
            }
            completion:^(BOOL finished) {
                [self.tipsView removeFromSuperview];
                [self.tipsView setText:text];
                [self performSelector:@selector(hide) withObject:self afterDelay:2];
                [self show];
                return;
            }];
        self.isShow = NO;
    } else {
        [self.tipsView setText:text];
        [self performSelector:@selector(hide) withObject:self afterDelay:2];
        [self show];
    }
}


- (void)show {
    self.tipsView.centerX = kScreenWidth * 0.5;
    self.tipsView.centerY = kScreenHeight * 0.5;
    [[self.tipsView getCurrentVC].view addSubview:self.tipsView];
    self.tipsView.alpha = 0;
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.tipsView.alpha = 1;
                     }];
    self.isShow = YES;
}

- (void)hide {
    [NSRunLoop cancelPreviousPerformRequestsWithTarget:self];
    [UIView animateWithDuration:0.25
        animations:^{
            self.tipsView.alpha = 0;
        }
        completion:^(BOOL finished) {
            [self.tipsView removeFromSuperview];
        }];
    self.isShow = NO;
}


#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

- (MYTipsView *)tipsView {
    if (!_tipsView) {
        _tipsView = [MYTipsView tipsViewWithTitle:@""];
    }
    return _tipsView;
}

@end
