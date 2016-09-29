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


@interface MYLoginViewController () <MYLoginIconViewDelegate>

@property (strong, nonatomic) MYLoginIconView *iconView;


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
    self.iconView.height = 100;
    self.iconView.centerX = self.view.width * 0.5;
    self.iconView.bottom = self.view.bottom;
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (BOOL)isBarAlpha {
    return YES;
}

#pragma mark - --------------------功能函数------------------
#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
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
    }
    [[MYLoginManager sharedInstance] loginWithType:type];
}

#pragma mark - --------------------属性相关------------------

- (MYLoginIconView *)iconView {
    if (!_iconView) {
        _iconView = [MYLoginIconView loginIconView];
        _iconView.delegate = self;
#if DEBUG
        _iconView.layer.borderColor = [UIColor blueColor].CGColor;
        _iconView.layer.borderWidth = 1;
#endif
    }
    return _iconView;
}


@end
