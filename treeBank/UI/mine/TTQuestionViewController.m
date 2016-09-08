//
//  TTQuestionViewController.m
//  treeBank
//
//  Created by kebi on 16/4/28.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTQuestionViewController.h"
#import "TTUIViewAdditons.h"

@interface TTQuestionViewController ()

@end
@interface TTQuestionViewController () <UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation TTQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"常见问题";
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_webView];
    _webView.delegate = self;

    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"questions/1" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [_webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _webView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
}

- (BOOL)shouldHideNavigationBar {
    return NO;
}

- (BOOL)webView:(UIWebView *)webView
    shouldStartLoadWithRequest:(NSURLRequest *)request
                navigationType:(UIWebViewNavigationType)navigationType {

    return YES;
}

@end
