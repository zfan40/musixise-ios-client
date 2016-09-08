//
//  TTMainPageViewController.m
//  treeBank
//
//  Created by kebi on 16/4/17.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "BAudioController.h"
#import "TTBannerView.h"
#import "TTMainGridView.h"
#import "TTMainHeadView.h"
#import "TTMainPageViewController.h"
#import "TTNavigator.h"
#import "TTRouter.h"
#import "TTRunTime.h"
#import "TTTipsHelper.h"
#import "TTUISkeleton.h"
#import "TTUIViewAdditons.h"
#import <WebViewJavascriptBridge/WebViewJavascriptBridge.h>

@interface TTMainPageViewController ()

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) WebViewJavascriptBridge *bridge;
@property (nonatomic, strong) BAudioController *audioPlayer;
@end

@implementation TTMainPageViewController {
    UITextField *_textFiled;
}

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Musixise";
    [self initViews];
    self.customNavigationBar.backButton.hidden = YES;
}

- (void)initViews {

    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height - 64)];
    [self.view addSubview:_webView];
    self.view.clipsToBounds = YES;

    _audioPlayer = [BAudioController new];

    [_audioPlayer setInputVolume:1.0 withBus:0];

    _bridge = [WebViewJavascriptBridge bridgeForWebView:_webView
                                        webViewDelegate:nil
                                                handler:^(id data, WVJBResponseCallback responseCallback) {
                                                    //默认的handler
                                                    responseCallback(@"Response for message from ObjC");
                                                }];

    [_bridge registerHandler:@"MusicDeviceMIDIEvent"
                     handler:^(id data, WVJBResponseCallback responseCallback) {
                         MusicDeviceMIDIEvent(self.audioPlayer.samplerUnit, [data[0] integerValue],
                                              [data[1] integerValue], [data[2] integerValue], [data[3] integerValue]);

                     }];
    [_bridge registerHandler:@"EnterStage"
                     handler:^(id data, WVJBResponseCallback responseCallback) {

                         [[TTRouter defaultRouter] route:@"treeBank://interPage/TTWebViewController"
                                               withParam:@{
                                                   @"url": data ? data : @""
                                               }];
                     }];
    //@"http://m.musixise.com/"

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.musixise.com/stagelist"]];
    [_webView loadRequest:request];
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (BOOL)shouldHideNavigationBar {
    return NO;
}

- (BOOL)shouldHideBackgroundImage {
    return YES;
}
#pragma mark - --------------------功能函数------------------

- (void)onClick {
    [[TTRouter defaultRouter] route:@"treeBank://interPage/TTWebViewController" withParam:nil];
}
#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

- (void)play:(NSArray *)data {
    NSLog(@"%ld-----", (long)[data[0] integerValue]);
    MusicDeviceMIDIEvent(self.audioPlayer.samplerUnit, [data[0] integerValue], [data[1] integerValue],
                         [data[2] integerValue], 0);
}

@end
