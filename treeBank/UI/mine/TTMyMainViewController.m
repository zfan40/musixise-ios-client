//
//  TTMyMainViewController.m
//  treeBank
//
//  Created by kebi on 16/4/17.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTMyMainViewController.h"
#import "TTMainHeadView.h"
#import "TTUIViewAdditons.h"
#import "TTMyMainTableViewCell.h"
#import "TTUser.h"
#import "TTMyCountModel.h"
#import "TTUtility.h"
#import "TTRunTime.h"
#import "TTAuthModel.h"
#import "TTRouter.h"
#import "TTActionSheet.h"

@interface TTMyMainViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation TTMyMainViewController{
    TTMainHeadView *_headView;
    UITableView *_tableView;
    UIImageView *_avatImageView;
    TTMyCountModel *_accountModel;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    return;
//    _accountModel =[TTMyCountModel new];
//    _headView =[TTMainHeadView new];
//    _headView.rightButton.titleLabel.font = [UIFont systemFontOfSize:12];
//    _headView.titleLab.text = @"我的账户";
//    [_headView.leftButton setTitle:@"" forState:UIControlStateNormal];
//    [_headView.leftButton setImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
//    _headView.collectionMoney.hidden = YES;
//    _headView.getMoney.hidden = YES;
//    _avatImageView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"avatar"]];
//    [_headView addSubview:_avatImageView];
//    _tableView =[UITableView new];
//    [self.view addSubview:_tableView];
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _tableView.delegate = self;
//    _tableView.dataSource = self;
//    [_headView.leftButton addTarget:self action:@selector(onMessage) forControlEvents:UIControlEventTouchUpInside];
//    [_headView.rightButton addTarget:self action:@selector(onLogoOut) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_headView];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onUserChanged) name:kTTUserChangedNotification  object:nil];
//    [self onUserChanged];

}

-(void)onMessage{
    if(![TTRunTime instance].user){
        [[TTRouter defaultRouter]route:@"treeBank://interPage/TTLoginViewController" withParam:nil];
    }else{
        [[TTRouter defaultRouter]route:@"treeBank://interPage/TTMessageListViewController" withParam:nil];
    }
}


-(void)onUserChanged{
    if([TTRunTime instance].user){
        [_headView.rightButton setTitle:@"安全退出" forState:UIControlStateNormal];
    }else{
        [_headView.rightButton setTitle:@"登录" forState:UIControlStateNormal];
    }
    [_tableView reloadData];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if( 1== section ){
        return _accountModel.datas.count;
    }
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view =[UIView new];
    view.backgroundColor = RGB(240, 240, 240);
    return view;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TTMyMainTableViewCell *cell =[ tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if( !cell ){
        cell =[[ TTMyMainTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    cell.showIndicator = YES;
    if( 0== indexPath.section ){
        cell.logoUrl = @"mobile";
        cell.title = @"手机号";
        cell.detailLab.text = [TTRunTime instance].user.mobile;
        cell.showIndicator = NO;
    }else if (2==indexPath.section ){
        cell.logoUrl = @"call";
        cell.title = @"致电客服";
        cell.detailLab.text = @"400-000-7077";
    }else{
        TTMyCountItem *item =[_accountModel.datas objectAtIndex:indexPath.row];
        cell.logoUrl = item.logo;
        cell.title = item.title;
        cell.detailLab.text = item.detailTitle;
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if( indexPath.section==1){
        if( ![TTRunTime instance].user&& 5!=indexPath.row ){
            [[TTRouter defaultRouter]route:@"treeBank://interPage/TTLoginViewController" withParam:nil];
            return;
        }
        
        if( 0== indexPath.row ){
            [[TTRouter defaultRouter]route:@"treeBank://interPage/TTAuthViewController" withParam:nil];
        }else if (1==indexPath.row ){
            [[TTRouter defaultRouter]route:@"treeBank://interPage/TTAuthPostViewController" withParam:@{@"model":[TTAuthModel new]}];
        }else if ( 2==indexPath.row ){
            [[TTRouter defaultRouter]route:@"treeBank://interPage/TTMyBankListViewController" withParam:nil];
        }
        else if ( 3== indexPath.row ){
            [[TTRouter defaultRouter]route:@"treeBank://interPage/TTDeviceManagerViewController" withParam:nil];
        }else if ( 4== indexPath.row ){
            [[TTRouter defaultRouter]route:@"treeBank://interPage/TTRevisPasswordViewController" withParam:nil];
        }else if ( 5== indexPath.row ){
            [[TTRouter defaultRouter]route:@"treeBank://interPage/TTQuestionViewController" withParam:nil];
        }
    }else if ( 2== indexPath.section ){
        [TTActionSheet showActionSheetWithTitle:[NSString stringWithFormat:@"是否拨打电话:400-000-7077"] subview:self.view cancelButtonTitle:@"取消" destructiveButtonTitle:@"立即拨打" otherButtonTitles:nil onDismiss:^(int buttonIndex) {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://400-000-7077"]];
            [[UIApplication sharedApplication] openURL:url];
        } onCancel:^{
            
        }];
        
    }
    
    
    
    
}
-(BOOL)shouldHideNavigationBar{
    return NO;
}

-(void)onLogoOut{
    if( [TTRunTime instance].user){
        [TTRunTime instance].user = nil;
        [[NSNotificationCenter defaultCenter]postNotificationName:kTTUserChangedNotification object:nil];
    }else{
        [[TTRouter defaultRouter]route:@"treeBank://interPage/TTLoginViewController" withParam:nil];
    }
}



-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
//    _headView.frame = CGRectMake(0, 0, self.view.width, 170);
//    _tableView.frame = CGRectMake(0, _headView.bottom, self.view.width, self.view.height-_headView.bottom);
//    _avatImageView.frame = CGRectMake( (_headView.width-65)/2.0, _headView.height-65-20, 65, 65);
}




@end
