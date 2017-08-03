//
//  MYWebUtils.m
//  musixise
//
//  Created by wmy on 2017/8/3.
//  Copyright © 2017年 wmy. All rights reserved.
//

#import "MYWebUtils.h"
#import <UIKit/UIKit.h>

@implementation MYWebUtils

- (void)configUserAgent {
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    NSString *oldAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    //add my info to the new agent
    NSString *newAgent = [NSString stringWithFormat:@"Musixise %@",oldAgent];
    //regist the new agent
    NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:newAgent, @"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
}

@end
