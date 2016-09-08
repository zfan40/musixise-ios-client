//
//  TTSettingViewController.m
//  treeBank
//
//  Created by kebi on 16/3/22.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTSettingViewController.h"

@implementation TTSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 200, 50, 40);
    btn.backgroundColor = [UIColor redColor];

    UIButton *btdn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btdn];
    [btdn addTarget:self action:@selector(ontt) forControlEvents:UIControlEventTouchUpInside];
    btdn.frame = CGRectMake(0, 300, 50, 40);
    btdn.backgroundColor = [UIColor redColor];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 400, 60, 44);
    [button setTitle:@"关闭" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.backgroundColor = [UIColor blueColor];
}

- (void)goBack:(id)sender {
}

- (void)ontt {
}

- (void)onClick {
}
@end
