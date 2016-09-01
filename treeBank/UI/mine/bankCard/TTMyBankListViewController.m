//
//  TTMyBankListViewController.m
//  treeBank
//
//  Created by kebi on 16/5/30.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTMyBankListViewController.h"

#import "TTDeviceManagerViewController.h"
#import "TTUIViewAdditons.h"
#import "TTUser.h"
#import "TTUtility.h"
#import "TTRunTime.h"
#import "TTRouter.h"
#import "TTTipsHelper.h"
#import "TTActionSheet.h"
#import "TTApiService.h"
#import "TTAuthModel.h"
#import "TTAuthModel.h"

@interface TTMyBankListViewController ()
@end

@implementation TTMyBankListViewController{
    TTAuthModel *_model;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的银行卡";
}

-(void)loadData{
    [theApiService  postRequest:@"/account/userbank.htm" parameter:@{@"token":[TTRunTime instance].user.token,@"memberid":[TTRunTime instance].user.objId} block:^(id result, BOOL ret, NSError *error) {
        BOOL status =[[result objectForKey:@"success"]boolValue];
        NSString *message =[result objectForKey:@"message"];
        
        
        {
            [TTTipsHelper showTip:message];
        }
        
    }];
}

-(IBAction)onRevise:(id)sender{
    [self route:@"treeBank://interPage/TTReviseBankInfoViewController" withParam:@{ @"model":[TTAuthModel new] }];

    
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    CGSize size = self.view.frame.size;
    
    
}



@end
