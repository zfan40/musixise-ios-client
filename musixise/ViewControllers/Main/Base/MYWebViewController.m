//
//  MYWebViewController.m
//  Pods
//
//  Created by wmy on 16/9/28.
//
//

#import "MYWebViewController.h"
#import <MYAudio/BPlayerAudioManager.h>
#import <libextobjc/EXTScope.h>
#import <WebViewJavascriptBridge/WebViewJavascriptBridge.h>
#import <MYUserSystem/MYUserUtils.h>
#import <MYUserSystem/MYUser.h>
#import <MYWidget/MYTipsHelper.h>
#import <MYAudio/MYPlayerEngine.h>
#import "MYImageBrowser.h"

@interface MYWebViewController ()

@property (nonatomic, strong) BPlayerAudioManager *audioPlayer;
@property WebViewJavascriptBridge *bridge;

@end

@implementation MYWebViewController

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------


- (void)viewDidLoad {
    [super viewDidLoad];
    self.bridge = self.bridge;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
//    _bridge = nil;
    
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------
#pragma mark - --------------------功能函数------------------
#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

- (BPlayerAudioManager *)audioPlayer {
    if (!_audioPlayer) {
        _audioPlayer = [[BPlayerAudioManager alloc] init];
        [_audioPlayer setInputVolume:1.0 withBus:0];
    }
    return _audioPlayer;
}

- (WebViewJavascriptBridge *)bridge {
    if (!_bridge) {
        _bridge = [WebViewJavascriptBridge bridgeForWebView:[self webView]];
        [_bridge registerHandler:@"MusicDeviceMIDIEvent"
                         handler:^(id data, WVJBResponseCallback responseCallback) {
                             MusicDeviceMIDIEvent(self.audioPlayer.samplerUnit, [data[0] integerValue],
                                                  [data[1] integerValue], [data[2] integerValue], [data[3] integerValue]);
                         }];
        [_bridge registerHandler:@"PushWebPage"
                         handler:^(id data, WVJBResponseCallback responseCallback) {
                             NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                             [dict setObject:data forKey:@"url"];
#if DEBUG
                             NSLog(@"url = %@",data);
#endif
                             [router routeUrl:@"musixise://page/MYWebViewController" withParam:dict];
                         }];
        
        [_bridge registerHandler:@"GetUserInfo"
                         handler:^(id data, WVJBResponseCallback responseCallback) {
                             MYUser *user = [MYUserUtils sharedInstance].user;
                             NSDictionary *userDict = [user dictWithProperty];
                             if (responseCallback) {
                                 responseCallback(userDict);
                             }
                         }];
        [_bridge registerHandler:@"PlayMusic"
                         handler:^(id data, WVJBResponseCallback responseCallback) {
                             [[MYPlayerEngine sharedInstance] inputPlayerData:data];
//                             if (responseCallback) {
//                                 responseCallback(userDict);
//                             }
                         }];
        [_bridge registerHandler:@"UploadImage"
                         handler:^(id data, WVJBResponseCallback responseCallback) {
                             [[MYImageBrowser sharedInstance] imageBrowserWithBlock:^(NSString *imageUrl, BOOL success) {
                                 if (responseCallback) {
                                     responseCallback(imageUrl);
                                 }
                             }];
                         }];
        [_bridge registerHandler:@"SetTitle"
                         handler:^(id data, WVJBResponseCallback responseCallback) {
                             NSString *title = data;
                             self.title = title;
                         }];
        [_bridge registerHandler:@"ShowToast"
                         handler:^(id data, WVJBResponseCallback responseCallback) {
                             NSString *title = data;
                             [[MYTipsHelper sharedInstance] showTips:title];
                         }];
    }
    return _bridge;
}

- (NSString *)dictToJsonStr:(NSDictionary *)dict{
    NSString *jsonString = nil;
    if ([NSJSONSerialization isValidJSONObject:dict])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        jsonString =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        //NSLog(@"json data:%@",jsonString);
        if (error) {
            NSLog(@"Error:%@" , error);
        }
    }
    return jsonString;
}

@end
