//
//  TTWebViewController.m
//

#import "TTWebViewController.h"
#import <WebViewJavascriptBridge/WebViewJavascriptBridge.h>
#import "BAudioController.h"


@interface TTWebViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) WebViewJavascriptBridge *bridge;
@property (nonatomic, strong) WebViewJavascriptBridge *bridge2;
@property (nonatomic, strong) BAudioController *audioPlayer;

@end

@implementation TTWebViewController{
    UITextField *_textFiled;
}

-(void)dealloc{
    _webView = nil;
    _bridge2 = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _webView =[UIWebView new];
    [self.view addSubview:_webView];
    
    _audioPlayer = [BAudioController new];
    [_audioPlayer setInputVolume:1.0 withBus:0];
    
    
    
    _bridge2 = [WebViewJavascriptBridge bridgeForWebView:_webView
                                         webViewDelegate:nil
                                                 handler:^(id data, WVJBResponseCallback responseCallback) {
                                                     //默认的handler
                                                     responseCallback(@"Response for message from ObjC");
                                                 }];
    
    [_bridge2 registerHandler:@"MusicDeviceMIDIEvent" handler:^(id data, WVJBResponseCallback responseCallback) {
      //  [self performSelector:@selector(play:) withObject:data afterDelay:[data[3]integerValue]];

        MusicDeviceMIDIEvent(self.audioPlayer.samplerUnit, [data[0] integerValue], [data[1]integerValue], [data[2]integerValue], [data[3]integerValue]);
        
    }];
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [_webView loadRequest:request];
    _webView.frame = self.view.bounds;
    _webView.frame =  [UIScreen mainScreen].bounds;
    self.navigationController.navigationBarHidden = YES;
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
//                                                  forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [_webView stopLoading];
    _webView = nil;
    _bridge2 = nil;
}


-(void)play:(NSArray*)data{
    NSLog(@"%d-----",[data[0]integerValue]);
    MusicDeviceMIDIEvent(self.audioPlayer.samplerUnit, [data[0]integerValue], [data[1]integerValue], [data[2]integerValue], 0);
}





@end
