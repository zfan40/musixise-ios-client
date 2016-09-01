//
//  TTReviseBankInfoViewController.m
//  treeBank
//
//  Created by kebi on 16/5/30.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTReviseBankInfoViewController.h"
#import "TTUIViewAdditons.h"
#import "TTUtility.h"
#import <TPKeyboardAvoidingTableView.h>
#import <libextobjc/EXTScope.h>
#import "TTAuthTableViewCell.h"
#import "TTRouter.h"
#import "TTBaseModel.h"
#import "TTCityModel.h"
#import "TTRankListModel.h"
#import "TTBankCardReviseTableViewCell.h"



@interface TTReviseBankInfoViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong)UITableView *tableView;

@end

@implementation TTReviseBankInfoViewController{
    NSArray *_datas;
    UITextField *_textFiled;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更改绑定银行卡";
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
    if(0==indexPath.section){
        return 40;
    }
    return 215;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if( 0== section ){
        return 6;
    }
    return 1;
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
    return 0;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if( 1== indexPath.section ){
        TTBankCardReviseTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cellBottom"];
        if( !cell ){
            cell =[[ TTBankCardReviseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellBottom"];
        }
        return cell;
    }
    
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
            cell.title = @"持卡人:";
            cell.textFiled.text = _model.name;
        }else if( 2== indexPath.row ){
            cell.textFiled.hidden = YES;
            cell.title = @"开户银行:";
            cell.showIndicator = YES;
            cell.detailTitle = _model.accountBankName;
        }else if ( 1== indexPath.row ){
            cell.textFiled.hidden = YES;
            cell.title = @"省份地区:";
            cell.showIndicator = YES;
            cell.detailTitle = _model.areaName;
        }else if ( 3== indexPath.row ){
            cell.textFiled.placeholder = @"请输入支行名称";
            cell.title = @"支行名称:";
            cell.textFiled.text= _model.bankName;
        }else if ( 4== indexPath.row ){
            cell.textFiled.placeholder = @"请输入您的储蓄银行卡号";
            cell.title = @"银行卡号:";
            cell.textFiled.text = _model.bankCard;
        }else if( 5==indexPath.row ){
            cell.textFiled.placeholder = @"请确认您的储蓄银行卡号";
            cell.title = @"确认卡号:";
            cell.textFiled.text = _model.okBankCard;
        }
    }
    
    return cell;
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    TTAuthTableViewCell *cell = (TTAuthTableViewCell*)textField.superview;
    NSString *text  = cell.title;
    NSString *textFiledText = textField.text;
    if( [text isEqualToString:@"持卡人:"]){
        _model.name = textFiledText;
    }else if ([text isEqualToString:@"支行名称:"]){
        _model.bankName = textFiledText;
    }else if ([text isEqualToString:@"银行卡号:"]){
        _model.bankCard = textFiledText;
    }else if ([text isEqualToString:@"确认卡号:"]){
        _model.okBankCard = textFiledText;
    }
    return YES;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if([_textFiled isFirstResponder]){
        [_textFiled resignFirstResponder];
    }
}

-(void)onClickNext{
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    @weakify(self)
    if( indexPath.section==0 ){
        if( 2== indexPath.row ){
            void(^bankBlock)(TTBankModel* model ) = ^(TTBankModel* model){
                @strongify(self)
                self.model.accountBankId = model.bankCode;
                self.model.accountBankName = model.bankShortname;
                [_tableView reloadData];
            };
            [[TTRouter defaultRouter]route:@"treeBank://interPage/TTBankViewController" withParam:@{@"bankBlock":bankBlock}];
        }else if ( 1== indexPath.row ){
            
            void(^block)(TTProvinceModel* model,TTCityModel *cityModel )= ^( TTProvinceModel* model,TTCityModel *cityModel){
                self.model.provinceCardId = model.provid;
                self.model.cityCardId = cityModel.cityid;
                self.model.areaName = [NSString stringWithFormat:@"%@%@",model.provshortname, cityModel.cityshortname];
                [_tableView reloadData];
                
            };
            
            [[TTRouter defaultRouter]route:@"treeBank://interPage/TTAreaViewController" withParam:@{@"provinceBlock":block}];
        }
    }
}

@end
