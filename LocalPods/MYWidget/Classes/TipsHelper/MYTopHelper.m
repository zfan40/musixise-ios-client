//
//  MYTopHelper.m
//  Pods
//
//  Created by wmy on 16/2/2.
//
//

#import "MYTopHelper.h"
#import "MYTopView.h"
#import "UIView+MYAdditons.h"
#import "UIView+MYCurrentViewController.h"

@interface MYTopHelper ()

@property (nonatomic, strong) MYTopView *topView;
@property (nonatomic, assign) BOOL isShow;

@end

@implementation MYTopHelper

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (void)showTipsOnTop:(NSString *)text {

    if (self.isShow) {
        [NSRunLoop cancelPreviousPerformRequestsWithTarget:self];
        [UIView animateWithDuration:0.25
            animations:^{
                self.topView.alpha = 0;
            }
            completion:^(BOOL finished) {
                [self.topView removeFromSuperview];
                [self.topView setText:text];
                [self performSelector:@selector(hide) withObject:self afterDelay:2];
                [self show];
                return;
            }];
        self.isShow = NO;
    } else {
        [self.topView setText:text];
        [self performSelector:@selector(hide) withObject:self afterDelay:2];
        [self show];
    }
}

- (void)show {
    self.topView.centerX = kScreenWidth * 0.5;
    self.topView.centerY = kScreenHeight * 0.5;
    [[self.topView getCurrentVC].view addSubview:self.topView];
    self.topView.alpha = 0;
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.topView.alpha = 1;
                     }];
    self.isShow = YES;
}

- (void)hide {
    [NSRunLoop cancelPreviousPerformRequestsWithTarget:self];
    [UIView animateWithDuration:0.25
        animations:^{
            self.topView.alpha = 0;
        }
        completion:^(BOOL finished) {
            [self.topView removeFromSuperview];
        }];
    self.isShow = NO;
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------
#pragma mark - --------------------功能函数------------------
#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

- (MYTopView *)topView {
    if (!_topView) {
        _topView = [MYTopView topView];
    }
    return _topView;
}

@end
