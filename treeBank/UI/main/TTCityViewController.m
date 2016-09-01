//
//  TTCityViewController.m
//  treeBank
//
//  Created by kebi on 16/4/23.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTCityViewController.h"

#import "TTCityModel.h"
#import "TTProvinceModel.h"
#import "TTUIViewAdditons.h"
#import "TTUser.h"
#import "TTUtility.h"
#import "TTRunTime.h"
#import "TTRouter.h"
#import "TTAreaTableViewCell.h"


@interface TTCityViewController ()<UITableViewDataSource, UITableViewDelegate>
@end

@implementation TTCityViewController{
    UITableView *_tableView;
    TTCityListModel *_listModel;
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"省份地区";
    _listModel =[TTCityListModel new];
    _listModel.provinceModel = self.model;
    [_listModel load];
    _tableView =[UITableView new];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onDataChanged) name:kTTCityDataChangedNotification object:nil];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    _tableView.frame = CGRectMake(0, 64, self.view.width, self.view.height-64);
}


-(void)onDataChanged{
    [_tableView reloadData];
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
    UIView *view =[UIView new];
    UILabel *lab =[[UILabel alloc]initWithFrame:CGRectMake(20, 0, tableView.width, 40)];
    lab.textAlignment = NSTextAlignmentLeft;
    lab.text = @"全部";
    [view addSubview:lab];
    return view;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TTAreaTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if( !cell ){
        cell =[[TTAreaTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    cell.showIndicator = NO;
    TTCityModel *model = [_listModel.datas objectAtIndex:indexPath.row];
    cell.textLabel.text = model.cityname;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    TTCityModel *model = [_listModel.datas objectAtIndex:indexPath.row];
    self.block(self.model,model);
    [self route:@"treeBank://interBack" withParam:@{ @"viewController": @"TTAuthViewController" }];
}


@end
