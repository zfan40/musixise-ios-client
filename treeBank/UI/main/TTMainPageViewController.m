//
//  TTMainPageViewController.m
//  treeBank
//
//  Created by kebi on 16/4/17.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTMainPageViewController.h"
#import "TTMainHeadView.h"
#import "TTUIViewAdditons.h"
#import "TTUISkeleton.h"
#import "TTNavigator.h"
#import "TTRouter.h"
#import "TTBannerView.h"
#import "TTMainGridView.h"
#import "TTRunTime.h"
#import "TTTipsHelper.h"
#import <WebViewJavascriptBridge/WebViewJavascriptBridge.h>
#import "BAudioController.h"

@interface TTMainPageViewController ()<UITableViewDelegate,UITextFieldDelegate,UITableViewDataSource,TTBannerScrollViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) WebViewJavascriptBridge *bridge;
@property (nonatomic, strong) BAudioController *audioPlayer;
@end

@implementation TTMainPageViewController{
    UITextField *_textFiled;
}

-(BOOL)shouldHideNavigationBar{
    return NO;
}


-(BOOL)shouldHideBackgroundImage{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Musixise";
    [self initViews];
    self.customNavigationBar.backButton.hidden = YES;
}

-(void)onClick{
    [[TTRouter defaultRouter]route:@"treeBank://interPage/TTWebViewController" withParam:nil];

}


-(void)initViews{
    
    _webView =[[UIWebView alloc]initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64)];
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
    
    [_bridge registerHandler:@"MusicDeviceMIDIEvent" handler:^(id data, WVJBResponseCallback responseCallback) {
        MusicDeviceMIDIEvent(self.audioPlayer.samplerUnit, [data[0]integerValue], [data[1]integerValue], [data[2]integerValue], [data[3]integerValue]);
        
    }];
    [_bridge registerHandler:@"EnterStage" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        [[TTRouter defaultRouter]route:@"treeBank://interPage/TTWebViewController" withParam:@{@"url":data?data:@""}];
    }];

    
    
    //@"http://m.musixise.com/"
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.musixise.com/stagelist"]];
    [_webView loadRequest:request];
    //        _webView.delegate = self;
    //    NSString *resourcePath = [ [NSBundle mainBundle] resourcePath];
    //    NSString *filePath  = [resourcePath stringByAppendingPathComponent:@"piano.html"];
    //    NSString *htmlstring =[[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    //    [self.webView loadHTMLString:htmlstring  baseURL:[NSURL fileURLWithPath: [[NSBundle mainBundle]  bundlePath]]];
    
    
}



-(void)play:(NSArray*)data{
    NSLog(@"%ld-----",(long)[data[0]integerValue]);
    MusicDeviceMIDIEvent(self.audioPlayer.samplerUnit, [data[0]integerValue], [data[1]integerValue], [data[2]integerValue], 0);
}




//-(void)onLeftSearchPay{
//    if([TTRunTime instance].user){
//        [TTTipsHelper showTip:@"正在开发中..." ];
//    }else{
//        [[TTRouter defaultRouter]route:@"treeBank://interPage/TTLoginViewController" withParam:nil];
//    }
//}

@end
