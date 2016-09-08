//
//  TTDeviceManagerViewController.m
//  treeBank
//
//  Created by kebi on 16/4/23.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTActionSheet.h"
#import "TTApiService.h"
#import "TTDeviceManagerViewController.h"
#import "TTRouter.h"
#import "TTRunTime.h"
#import "TTTipsHelper.h"
#import "TTUIViewAdditons.h"
#import "TTUser.h"
#import "TTUtility.h"
#import <MESDK/MESDK.h>
#import <MESDK/NLBluetoothHelper.h>
#import <MESDK/NLDeviceLaunchEvent.h>
#import <MESDK/NLDeviceMenuEvent.h>

@interface TTDeviceManagerViewController ()
@property (nonatomic, strong) IBOutlet UIButton *deviceBtn1;
@property (nonatomic, strong) IBOutlet UIButton *deviceBtn2;
@property (nonatomic, strong) IBOutlet UILabel *lab;
@property (nonatomic, strong) IBOutlet UIButton *device1TextBtn;
@property (nonatomic, strong) IBOutlet UIButton *device2TextBtn;

@end

@implementation TTDeviceManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定刷卡器";
    UIColor *borderColor = RGBA(0, 0, 0, 0.2);
    _lab.layer.borderColor = borderColor.CGColor;
    _lab.layer.borderWidth = 0.5;
    _device1TextBtn.layer.borderWidth = 0.5;
    _device2TextBtn.layer.borderWidth = 0.5;
    _device1TextBtn.layer.borderColor = borderColor.CGColor;
    _device2TextBtn.layer.borderColor = borderColor.CGColor;
    _device1TextBtn.backgroundColor = [UIColor whiteColor];
    _device2TextBtn.backgroundColor = [UIColor whiteColor];
    [theApiService postRequest:@"/account/poslist.htm"
                     parameter:@{
                         @"token": [TTRunTime instance].user.token,
                         @"memberid": [TTRunTime instance].user.objId
                     }
                         block:^(id result, BOOL ret, NSError *error) {
                             NSString *message = [result objectForKey:@"message"];

                             { [TTTipsHelper showTip:message]; }

                         }];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGSize size = self.view.frame.size;
    _lab.frame = CGRectMake(-2, _lab.top, size.width + 4, _lab.height);
    _deviceBtn1.frame = CGRectMake(30, _lab.bottom + 25, (size.width - 60 - 20) / 2.0, 125);
    _deviceBtn2.frame = CGRectMake(_deviceBtn1.right + 20, _deviceBtn1.top, _deviceBtn1.width, _deviceBtn1.height);
    _device1TextBtn.frame = _deviceBtn1.frame;
    _device1TextBtn.top = _deviceBtn1.bottom + 10;
    _device1TextBtn.height = 30;
    _device2TextBtn.frame = _deviceBtn2.frame;
    _device2TextBtn.top = _deviceBtn2.bottom + 10;
    _device2TextBtn.height = 30;
}

- (IBAction)onDev1:(id)sender {
}

- (IBAction)onDev2:(id)sender {
}

@end
