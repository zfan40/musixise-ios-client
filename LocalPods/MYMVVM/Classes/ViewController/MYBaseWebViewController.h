//
//  MYWebViewController.h
//  Pods
//
//  Created by wmy on 16/9/28.
//
//

#import "MYBaseViewController.h"

@interface MYBaseWebViewController : MYBaseViewController

@property (strong, nonatomic) NSString *url;
- (UIWebView *)webView;

@end
