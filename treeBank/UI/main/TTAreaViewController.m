//
//  TTAreaViewController.m
//  treeBank
//
//  Created by kebi on 16/4/23.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTAreaViewController.h"
#import "TTCityModel.h"
#import "TTProvinceModel.h"
#import "TTUIViewAdditons.h"
#import "TTUser.h"
#import "TTMyCountModel.h"
#import "TTUtility.h"
#import "TTRunTime.h"
#import "TTRouter.h"
#import "TTAreaTableViewCell.h"

@interface TTAreaViewController ()<UITableViewDataSource, UITableViewDelegate>
@end

@implementation TTAreaViewController{
    UITableView *_tableView;
    TTProvinceListModel *_listModel;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"省份地区";
    _listModel =[TTProvinceListModel new];
    [_listModel load];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onDataChanged) name:kTTProvinceDataChangedNotification object:nil];
    _tableView =[UITableView new];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
}

-(void)onDataChanged{
    [_tableView reloadData];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    _tableView.frame = CGRectMake(0, 64, self.view.width, self.view.height-64);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listModel.datas.count;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *lab =[[UILabel alloc]initWithFrame:CGRectMake(20, 0, tableView.width, 40)];
    lab.textAlignment = NSTextAlignmentLeft;
    lab.text = @"全部";
    return lab;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TTAreaTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if( !cell ){
        cell =[[TTAreaTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    
    TTProvinceModel *model = [_listModel.datas objectAtIndex:indexPath.row];
    cell.title = model.provname;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    TTProvinceModel *model = [_listModel.datas objectAtIndex:indexPath.row];
    [[TTRouter defaultRouter]route:@"treeBank://interPage/TTCityViewController" withParam:@{@"block":self.provinceBlock,@"model":model}];

}



@end
