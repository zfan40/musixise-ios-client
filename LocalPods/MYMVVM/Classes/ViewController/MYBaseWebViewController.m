//
//  MYWebViewController.m
//  Pods
//
//  Created by wmy on 16/9/28.
//
//

#import "MYBaseWebViewController.h"

@interface MYBaseWebViewController () <UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;

@end

@implementation MYBaseWebViewController

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    self.webView.width = kScreenWidth;
    self.webView.height = kScreenHeight - 64;
    self.webView.top = 0;
    self.webView.left = 0;
    if (!isEmptyString(self.url)) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
        [self.webView loadRequest:request];
    } else {
        DebugLog(@"url为空");
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.webView stopLoading];
    _webView = nil;
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------
#pragma mark - --------------------功能函数------------------
#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------

#pragma mark UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    DebugLog(@"");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    DebugLog(@"");
}

#pragma mark - --------------------属性相关------------------

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
    }
    return _webView;
}

@end
