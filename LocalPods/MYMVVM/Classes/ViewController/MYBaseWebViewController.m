//
//  MYWebViewController.m
//  Pods
//
//  Created by wmy on 16/9/28.
//
//

#import "MYBaseWebViewController.h"
#import <MJRefresh/MJRefresh.h>

@interface MYBaseWebViewController () <UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;
@property(nonatomic, strong) UIScrollView *scrollView;

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
   
    self.webView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后调用此block
        DebugLog(@"===================下拉刷新 %@===================",[self class]);
        if (!isEmptyString(self.url)) {
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
            [self.webView loadRequest:request];
            [self performSelector:@selector(endRefreshing) withObject:self afterDelay:2];
        } else {
            DebugLog(@"url为空");
        }    }];
    [self.webView.scrollView.mj_header beginRefreshing];

}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.webView stopLoading];
    _webView = nil;
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------
#pragma mark - --------------------功能函数------------------

- (void)endRefreshing {
    [self.webView.scrollView.mj_header endRefreshing];
}

#pragma mark - --------------------手势事件------------------


-(void)handleRefresh:(UIRefreshControl *)refresh {
    // Reload my data
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:self.url];
    [_webView loadRequest:requestObj];
    [refresh endRefreshing];
}

#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------

#pragma mark UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.webView.scrollView.mj_header endRefreshing];
}

#pragma mark - --------------------属性相关------------------

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = self.view.bounds;
    }
    return _scrollView;
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
    }
    return _webView;
}

@end
