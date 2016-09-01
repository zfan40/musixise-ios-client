//
//  TTAuthViewController.m
//  treeBank
//
//  Created by kebi on 16/4/23.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTAuthViewController.h"
#import "TTTipsHelper.h"
#import "TTUtility.h"
#import "TTRunTime.h"
#import "TTAuthTableViewCell.h"
#import "TTAuthModel.h"
#import "TTUIViewAdditons.h"
#import <libextobjc/EXTScope.h>
#import "TTApiService.h"
#import "TTRouter.h"
#import "TTProvinceModel.h"
#import "TTCityModel.h"
#import "TTRankListModel.h"
#import <TPKeyboardAvoiding/TPKeyboardAvoidingTableView.h>

@interface TTAuthViewController ()<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic ,strong) TTAuthModel *authModel;

@end

@implementation TTAuthViewController{
    TPKeyboardAvoidingTableView *_tableView;
    UITextField *_textFiled;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实名认证";
    _authModel =[TTAuthModel new];
    _tableView =[TPKeyboardAvoidingTableView new];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView reloadData];
    
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    _tableView.frame = self.view.bounds;
    _tableView.top = 64;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if( 0== section ){
        return 2;
    }
    return 5;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view =[UIView new];
    view.backgroundColor = RGB(240, 240, 240);
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(1==section){
        return 140;
    }
    return 0;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if( 1==section ){
        UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 130)];
        UILabel *labe =[ UILabel new];
        labe.text = @"为了你的账户资金安全，只能绑定持卡本人的银行卡";
        labe.font = [UIFont systemFontOfSize:12];
        labe.textColor = RGB(172, 172, 172);
        labe.textAlignment = NSTextAlignmentCenter;
        UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"下一步" forState:UIControlStateNormal];
        button.backgroundColor = RGB(27, 139, 209);
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font =[UIFont systemFontOfSize:18];
        [button addTarget:self action:@selector(onClickNext) forControlEvents:UIControlEventTouchUpInside];
        labe.frame = CGRectMake(0, 20, self.view.width , 20);
        button.frame = CGRectMake( 20, labe.bottom + 50, self.view.width-20*2, 40);
        [view addSubview:labe];
        [view addSubview:button];
        return view;

    }
    return nil;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TTAuthTableViewCell *cell =[ tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if( !cell ){;
        cell =[[TTAuthTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
        cell.textFiled.delegate = self;
    }
    _textFiled = cell.textFiled;
    cell.textFiled.hidden = NO;
    cell.showIndicator = NO;
    if( 0==indexPath.section ){
        if( 0== indexPath.row ){
            cell.textFiled.placeholder = @"请输入您的真实姓名";
            cell.title = @"姓名:";
            cell.textFiled.text = _authModel.name;
        }else if ( 1== indexPath.row ){
            cell.textFiled.placeholder = @"请输入您的身份证号";
            cell.title = @"身份证号码:";
            cell.textFiled.text = _authModel.idCard;
        }
    }else{
        if( 0== indexPath.row ){
            cell.textFiled.hidden = YES;
            cell.title = @"开户银行:";
            cell.showIndicator = YES;
            cell.detailTitle = _authModel.accountBankName;
        }else if ( 1== indexPath.row ){
            cell.textFiled.hidden = YES;
            cell.title = @"省份地区:";
            cell.showIndicator = YES;
            cell.detailTitle = _authModel.areaName;
        }else if ( 2== indexPath.row ){
            cell.textFiled.placeholder = @"请输入支行名称";
            cell.title = @"支行名称:";
            cell.textFiled.text= _authModel.bankName;
        }else if ( 3== indexPath.row ){
            cell.textFiled.placeholder = @"请输入您的储蓄银行卡号";
            cell.title = @"银行卡号:";
            cell.textFiled.text = _authModel.bankCard;
        }else if( 4==indexPath.row ){
            cell.textFiled.placeholder = @"请确认您的储蓄银行卡号";
            cell.title = @"确认卡号:";
            cell.textFiled.text = _authModel.okBankCard;
        }
    }
    
    return cell;

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    TTAuthTableViewCell *cell = (TTAuthTableViewCell*)textField.superview;
    NSString *text  = cell.title;
    NSString *textFiledText = textField.text;
    if( [text isEqualToString:@"姓名:"]){
        _authModel.name = textFiledText;
    }else if ([text isEqualToString:@"身份证号码:"]){
        _authModel.idCard = textFiledText;
    }else if ([text isEqualToString:@"支行名称:"]){
        _authModel.bankName = textFiledText;
    }else if ([text isEqualToString:@"银行卡号:"]){
        _authModel.bankCard = textFiledText;
    }else if ([text isEqualToString:@"确认卡号:"]){
        _authModel.okBankCard = textFiledText;
    }
    
    
    
    return YES;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if([_textFiled isFirstResponder]){
        [_textFiled resignFirstResponder];
    }
}

-(void)onClickNext{
    [[TTRouter defaultRouter]route:@"treeBank://interPage/TTAuthPostViewController" withParam:@{@"model":_authModel}];

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    @weakify(self)
    if( indexPath.section==1){
        if( 0== indexPath.row ){
            void(^bankBlock)(TTBankModel* model ) = ^(TTBankModel* model){
            @strongify(self)
                self.authModel.accountBankId = model.bankCode;
                self.authModel.accountBankName = model.bankShortname;
                [_tableView reloadData];
            };
            [[TTRouter defaultRouter]route:@"treeBank://interPage/TTBankViewController" withParam:@{@"bankBlock":bankBlock}];
        }else if ( 1== indexPath.row ){
            
            void(^block)(TTProvinceModel* model,TTCityModel *cityModel )= ^( TTProvinceModel* model,TTCityModel *cityModel){
                self.authModel.provinceCardId = model.provid;
                self.authModel.cityCardId = cityModel.cityid;
                self.authModel.areaName = [NSString stringWithFormat:@"%@%@",model.provshortname, cityModel.cityshortname];
                [_tableView reloadData];

            };

            [[TTRouter defaultRouter]route:@"treeBank://interPage/TTAreaViewController" withParam:@{@"provinceBlock":block}];
        }
    }
}



@end
