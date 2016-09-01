//
//  TTBusinessViewController.m
//  treeBank
//
//  Created by kebi on 16/4/17.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTBusinessViewController.h"
#import "TTBusinessHeadView.h"
#import "TTBusinessSubHeadView.h"
#import "TTUIViewAdditons.h"
#import "TTUtility.h"
#import "TTDealResultListModel.h"
#import "TTDealTableViewCell.h"
#import "TTUtility.h"
#import "TTItemView.h"

@interface TTBusinessViewController ()<UITableViewDataSource,UITableViewDelegate,TTViewEventProtocal>

@end

@implementation TTBusinessViewController{
    TTBusinessHeadView *_headView;
    TTBusinessSubHeadView *_subHeadView;
    UITableView *_tableView;
    TTDealResultListModel *_viewModel;
    BOOL _showSubHeadView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"MusicList";
    return;
    
    [self initViews];
    [self initDatas];
    [_tableView reloadData];
}

-(void)initDatas{
    _viewModel = [TTDealResultListModel new];
}

-(void)initViews{
    _headView = [[TTBusinessHeadView alloc]initWithFrame:CGRectZero];
    _tableView =[UITableView new];
    [self.view addSubview:_headView];
    [self.view addSubview:_tableView];
    _subHeadView =[[TTBusinessSubHeadView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_subHeadView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _headView.eventDelegate = self;
    _subHeadView.eventDelegate = self;
    _showSubHeadView = NO;
    _subHeadView.hidden = YES;
    self.customNavigationBar.backButton.hidden = YES;
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    _headView.frame = CGRectMake(0, 74, self.view.width, 40);
    _subHeadView.frame = CGRectMake( 0, _headView.bottom, self.view.width, 40);
    _tableView.frame = CGRectMake(0, _showSubHeadView?_subHeadView.bottom:_headView.bottom, self.view.width, self.view.height-(_showSubHeadView?_subHeadView.bottom:_headView.bottom));
}

-(BOOL)shouldHideNavigationBar{
    return NO;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _viewModel.datas.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TTDealTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if( !cell ){
        cell = [[TTDealTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    UIColor *cellBackgroudColor;
    if( indexPath.row %2==0 ){
        cellBackgroudColor = RGB(240, 240, 240);
    }else{
        cellBackgroudColor = RGB(209, 209, 209);
    }
    cell.backgroundColor = cellBackgroudColor;
    cell.model =[_viewModel.datas objectAtIndex:indexPath.row];
    return cell;
}


-(void)onEvent:(NSString *)event view:(UIView *)view parameter:(NSDictionary *)dics{
    if( [event isEqualToString:kClickDealResultSort] ){
        NSArray *datas= [dics objectForKey:@"datas"];
        _showSubHeadView =[[dics objectForKey:@"open"]boolValue];
        if(!datas){
            _showSubHeadView = NO;
        }
        if(datas&& _showSubHeadView){
            _subHeadView.datas = datas;
        }
    }
    _subHeadView.hidden = !_showSubHeadView;
    _tableView.frame = CGRectMake(0, _showSubHeadView?_subHeadView.bottom:_headView.bottom, self.view.width, self.view.height-(_showSubHeadView?_subHeadView.bottom:_headView.bottom));

}






@end
