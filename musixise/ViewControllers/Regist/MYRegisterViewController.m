//
//  MYRegistViewController.m
//  musixise
//
//  Created by wmy on 2016/12/4.
//  Copyright © 2016年 wmy. All rights reserved.
//

#import "MYRegisterViewController.h"
#import <MYWidget/MYLoginTextField.h>
#import <MYUserSystem/MYRegistModel.h>
#import <MYUserSystem/MYMusixiseRegisterManager.h>
#import <MYUserSystem/MYLoginManager.h>

#define kUserNameTop 150

@interface MYRegisterViewController ()

@property (strong, nonatomic) MYLoginTextField *userNameTextField;
@property (strong, nonatomic) MYLoginTextField *artistTextField;
@property (strong, nonatomic) MYLoginTextField *passwordTextField;
@property (strong, nonatomic) MYLoginTextField *comfirmPasswordTextField;
@property (strong, nonatomic) UIButton *registButton;

@end

@implementation MYRegisterViewController

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
}

- (void)initData {
    self.title = @"注册";
    self.registButton.width = self.userNameTextField.width;
    self.registButton.height = self.userNameTextField.height;
}

- (void)initView {
    [self.view addSubview:self.userNameTextField];
    [self.view addSubview:self.artistTextField];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.comfirmPasswordTextField];
    [self.view addSubview:self.registButton];
    
    self.userNameTextField.top = kUserNameTop;
    self.userNameTextField.centerX = kScreenWidth * 0.5;
    
    self.artistTextField.top = self.userNameTextField.bottom + theMYWidget.m3;
    self.artistTextField.centerX = self.userNameTextField.centerX;
    
    self.passwordTextField.top = self.artistTextField.bottom + theMYWidget.m3;
    self.passwordTextField.centerX = self.userNameTextField.centerX;
    
    self.comfirmPasswordTextField.top = self.passwordTextField.bottom + theMYWidget.m3;
    self.comfirmPasswordTextField.centerX = self.userNameTextField.centerX;
    
    self.registButton.top = self.comfirmPasswordTextField.bottom + theMYWidget.m3;
    self.registButton.centerX = self.userNameTextField.centerX;
    
    [self.registButton addTarget:self
                          action:@selector(onClickRegist)
                forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (BOOL)isBarAlpha {
    return YES;
}

#pragma mark - --------------------功能函数------------------

- (BOOL)checkUserName:(NSString *)userName {
    return !isEmptyString(userName);
}

- (BOOL)checkArtistName:(NSString *)artistName {
    return !isEmptyString(artistName);
}

- (BOOL)checkPassword:(NSString *)password andComfirmPassword:(NSString *)comfirmPassword {
    BOOL isEmptyPs = isEmptyString(password);
    BOOL isEmptyCPs = isEmptyString(comfirmPassword);
    if (!isEmptyPs && !isEmptyCPs) {
        // 两者都不为空 那么就判断两者是否相等
        if ([password isEqualToString:comfirmPassword]) {
            return YES;
        }
    }
    
    return NO;
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------

- (void)onClickRegist {
    //TODO: wmy 点击调用注册
    //1. 判断用户名是否为空
    BOOL checkUserName = [self checkUserName:self.userNameTextField.text];
    if (!checkUserName) {
        [self showTip:@"用户名不正确"];
        return;
    }
    //2. 判断艺名是否为空
    BOOL checkArtistName = [self checkArtistName:self.artistTextField.text];
    if (!checkArtistName) {
        [self showTip:@"艺名不正确"];
        return;
    }
    //3. 判断密码是否一致
    BOOL checkPs = [self checkPassword:self.passwordTextField.text
                    andComfirmPassword:self.comfirmPasswordTextField.text];
    if (!checkPs) {
        [self showTip:@"密码为空或两次密码不相等"];
    }
    if (checkPs && checkUserName && checkArtistName) {
        //4. 调用注册接口
        MYRegistModel *model = [[MYRegistModel alloc] init];
        model.username = self.userNameTextField.text;
        model.realname = self.artistTextField.text;
        model.password = self.passwordTextField.text;
        [[MYMusixiseRegisterManager sharedInstance] registerWithModel:model callback:^(BOOL success,NSError *error) {
            if (success) {
                //TODO: wmy 注册成功，当前的navigation window的rootViewController进行更换 销毁当前的navigation
                [[MYLoginManager sharedInstance] loginWithType:MYLoginType_Normal
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
            } else {
                //TODO: wmy 弹toast注册失败，然后看看注册失败的原因
                [self showTip:error.domain];
            }
        }];
    }
}
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

newInstanceStyleUIButton(registButton, @"注 册", MYButtonStyle_Normal_Big)

- (MYLoginTextField *)comfirmPasswordTextField {
    if (!_comfirmPasswordTextField) {
        _comfirmPasswordTextField = [MYLoginTextField loginTextFieldWithHint:@"请确认密码"];
        _comfirmPasswordTextField.secureTextEntry = YES;
    }
    return _comfirmPasswordTextField;
}

- (MYLoginTextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [MYLoginTextField loginTextFieldWithHint:@"请输入密码"];
        _passwordTextField.secureTextEntry = YES;
    }
    return _passwordTextField;
}

- (MYLoginTextField *)artistTextField {
    if (!_artistTextField) {
        _artistTextField = [MYLoginTextField loginTextFieldWithHint:@"请输入艺名"];
    }
    return _artistTextField;
}

- (MYLoginTextField *)userNameTextField {
    if (!_userNameTextField) {
        _userNameTextField = [MYLoginTextField loginTextFieldWithHint:@"请输入用户名"];
    }
    return _userNameTextField;
}

@end
