//
//  MYLoginViewController.m
//  musixise
//
//  Created by wmy on 16/9/28.
//  Copyright © 2016年 wmy. All rights reserved.
//

#import "MYLoginViewController.h"
#import "MYLoginIconView.h"
#import <MYUserSystem/MYLoginManager.h>
#import <MYWidget/MYLoginTextField.h>
#import <MYUserSystem/MYLoginManager.h>

#define kIconHeight 80
#define kIconBottomSpace 20
#define kSignBtnRightSpace 10
#define kSignBtnTopSpace 20

@interface MYLoginViewController () <MYLoginIconViewDelegate>

@property (strong, nonatomic) MYLoginIconView *iconView;
@property (strong, nonatomic) MYLoginTextField *userNameTextField;
@property (strong, nonatomic) MYLoginTextField *passwordTextField;
@property (strong, nonatomic) UIButton *loginButton;
@property (strong, nonatomic) UIImageView *iconImageView;
@property(nonatomic, strong) UIButton *signInBtn;

@end

@implementation MYLoginViewController



#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
}

- (void)initData {
    self.title = @"请登录";
}

- (void)initView {
    [self.view addSubview:self.iconView];
    self.iconView.width = kScreenWidth - theMYWidget.m3 * 2;
    self.iconView.height = kIconHeight;
    self.iconView.centerX = self.view.width * 0.5;
    self.iconView.bottom = self.view.bottom - kIconBottomSpace;
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.userNameTextField];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.iconImageView];
    self.passwordTextField.centerX = kScreenWidth * 0.5;
    self.passwordTextField.centerY = kScreenHeight * 0.5;
    
    self.userNameTextField.centerX = self.passwordTextField.centerX;
    self.userNameTextField.bottom = self.passwordTextField.top - theMYWidget.m3;
    
    self.iconImageView.centerY = self.userNameTextField.top * 0.5 + 20;
    self.iconImageView.centerX = kScreenWidth * 0.5;
    
    self.loginButton.width = self.userNameTextField.width;
    self.loginButton.height = self.userNameTextField.height;
    self.loginButton.top = self.passwordTextField.bottom + theMYWidget.m3;
    self.loginButton.left = self.userNameTextField.left;
    [self.loginButton addTarget:self action:@selector(onClickLogin) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.signInBtn];
    
    [self.signInBtn setTitle:@"注 册" forState:UIControlStateNormal];
    self.signInBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.signInBtn setTitleColor:theMYWidget.c0 forState:UIControlStateNormal];
    [self.signInBtn sizeToFit];
    self.signInBtn.right = kScreenWidth - kSignBtnRightSpace;
    self.signInBtn.top = kSignBtnTopSpace;
    [self.signInBtn addTarget:self
                       action:@selector(onClickSign)
             forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (BOOL)isBarAlpha {
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.userNameTextField endEditing:YES];
    [self.passwordTextField endEditing:YES];
}

#pragma mark - --------------------功能函数------------------
#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------

- (void)onClickLogin {
    [self loginIconViewDidClickIconWithTag:kNormalTag];
}

- (void)onClickSign {
    [router routeUrl:@"musixise://page/MYRegisterViewController"];
}

#pragma mark - --------------------代理方法------------------

#pragma mark MYLoginIconViewDelegate

- (void)loginIconViewDidClickIconWithTag:(NSInteger)tag {
    MYLoginType type ;
    if (tag == kQQTag) {
        DebugLog(@"qq登录");
        [self showTip:@"qq登录正在开发中...尽请期待"];
        type = MYLoginType_QQ;
    } else if (tag == kTaobaoTag) {
        DebugLog(@"淘宝登录");
        [self showTip:@"淘宝登录正在开发中...尽请期待"];
        type = MYLoginType_Taobao;
    } else if (tag == kWeiboTag) {
        DebugLog(@"微博登录");
        type = MYLoginType_Weibo;
    } else if (tag == kWeixinTag) {
        DebugLog(@"微信登录");
        [self showTip:@"微信登录正在开发中...尽请期待"];
        type = MYLoginType_Weixin;
    } else if (tag == kNormalTag) {
        type = MYLoginType_Normal;
    }
    [[MYLoginManager sharedInstance] loginWithType:type
                                          userName:self.userNameTextField.text
                                          password:self.passwordTextField.text
                                     loginCallback:^(BOOL success,NSError *error) {
                                         //TODO: wmy 成功或失败的回调
                                         DebugLog(@"");
                                         if (success) {
                                             [self showTip:@"登录成功"];
                                         } else {
                                             [self showTip:error.localizedDescription];
                                         }
                                     }];
}

#pragma mark - --------------------属性相关------------------

newInstanceUIButton1(signInBtn)

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        UIImage *image = [UIImage imageNamed:@"AppIcon60x60"];
        _iconImageView = [[UIImageView alloc] initWithImage:image];
    }
    return _iconImageView;
}


newInstanceStyleUIButton(loginButton, @"登 录", MYButtonStyle_Normal_Big)

- (MYLoginTextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [MYLoginTextField loginTextFieldWithHint:@"请输入密码"];
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.text = @"123456";
    }
    return _passwordTextField;
}

- (MYLoginTextField *)userNameTextField {
    if (!_userNameTextField) {
        _userNameTextField = [MYLoginTextField loginTextFieldWithHint:@"请输入用户名"];
        _userNameTextField.text = @"musixise001";
    }
    return _userNameTextField;
}

- (MYLoginIconView *)iconView {
    if (!_iconView) {
        _iconView = [MYLoginIconView loginIconView];
        _iconView.delegate = self;
    }
    return _iconView;
}


@end
