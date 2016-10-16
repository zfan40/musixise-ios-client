//
//  MYWebViewController.m
//  Pods
//
//  Created by wmy on 16/9/28.
//
//

#import "MYWebViewController.h"
#import <MYAudio/BAudioController.h>
#import <WebViewJavascriptBridge/WebViewJavascriptBridge.h>
//#import <AudioToolbox/AudioToolbox.h>

@interface MYWebViewController ()

@property (nonatomic, strong) BAudioController *audioPlayer;
@property (strong, nonatomic) WebViewJavascriptBridge *bridge;

@end

@implementation MYWebViewController

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.audioPlayer = self.audioPlayer;
    self.bridge = self.bridge;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    _bridge = nil;
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------
#pragma mark - --------------------功能函数------------------
#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

- (BAudioController *)audioPlayer {
    if (!_audioPlayer) {
        _audioPlayer = [BAudioController new];
        [_audioPlayer setInputVolume:1.0 withBus:0];
    }
    return _audioPlayer;
}

- (WebViewJavascriptBridge *)bridge {
    if (!_bridge) {
        _bridge = [WebViewJavascriptBridge bridgeForWebView:[self webView]
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
                             NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                             [dict setObject:data forKey:@"url"];
                             [router routeUrl:@"musixise://page/MYWebViewController" withParam:dict];
                         }];
        
    }
    return _bridge;
}

@end
