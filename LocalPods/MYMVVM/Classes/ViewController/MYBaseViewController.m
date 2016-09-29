//
//  MYBaseViewController.m
//  xiaplay
//
//  Created by wmy on 15/11/23.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import "MYBaseViewController.h"
#import <MYUtils/UIView+MYAdditons.h>
#import <MYUtils/UIImage+MYImage.h>
#import <MYWidget/MYWidget.h>
#import "MYBaseViewModel.h"
#import <MYWidget/UILabel+MYStyle.h>
#import <MYWidget/MYNoDataView.h>
#import "MYNoDataViewManager.h"
#import <MYNetwork/MYBaseNetWorkUtil.h>
#import <Reachability/Reachability.h>
#import <MYWidget/MYTipsHelper.h>
#import <MYUtils/UIImage+MYImage.h>

@interface MYBaseViewController () <MYNoDataViewDelegate>

@property (nonatomic,strong) MYNoDataView *noDataView;
@property (nonatomic,strong) MYNoDataViewManager *noDataViewManager;

@end

@implementation MYBaseViewController

#pragma mark - --------------------退出清空------------------

- (void)dealloc {
    [_viewModel removeObserver:self forKeyPath:kStateKey];
    [_viewModel removeObserver:self forKeyPath:kDataKey];
}

#pragma mark - --------------------初始化--------------------
#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == _viewModel) {
        if ([keyPath isEqualToString:kStateKey]) {
            if (![NSThread isMainThread]) {
                [self performSelectorOnMainThread:@selector(viewModeStateChanged) withObject:nil waitUntilDone:NO];
            }
            else{
                [self viewModeStateChanged];
//                [self viewModelDataChanged];
            }
            return;
        }else if([keyPath isEqualToString:kDataKey]) {
            if (![NSThread isMainThread]) {
                [self performSelectorOnMainThread:@selector(viewModelDataChanged) withObject:nil waitUntilDone:NO];
            }
            else{
                [self viewModelDataChanged];
            }
            return;
        }
    }
    
    return [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置背景
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.height = kScreenHeight;
    // 设置noDataView
    [self.noDataViewManager setViewType:[self noDataType]];
    [self.noDataViewManager setViewEmptyType:[self noDataEmptyType]];
    [self.view addSubview:self.noDataView];
    self.noDataView.width = kScreenWidth;
    self.noDataView.height = self.view.height;
    self.noDataView.hidden = YES;
    // check 网络状态
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onChangeNetwork)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.isBarAlpha) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.shadowImage = [UIImage new];
        self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    } else {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor blackColor]] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.shadowImage = [UIImage createImageWithColor:[UIColor blackColor]];
        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.view insertSubview:self.noDataView atIndex:0];
}
#pragma mark - --------------------功能函数------------------

- (void)showTip:(NSString *)string {
    [[MYTipsHelper sharedInstance] showTips:string];
}

- (MYNoDataType)noDataType {
    return MYNoDataViewType_No_NetWork;
}
- (MYNoDataEmptyType)noDataEmptyType {
    return MYNoDataEmptyType_Empty;
}

- (NSArray *)moreTitleArray {
    return @[@"首页",@"登录"];
}

- (void)clickMoreWithIndex:(NSInteger)index {
    MYNavigationController *navigationController = (MYNavigationController *)self.navigationController;
    if (index == 0) {
        [navigationController backToRoot];
    }
}

- (void)setTitle:(NSString *)title {
    UILabel *titleLabel = [UILabel labelWithStyle:MYWidgetStyle_MYWidget_tt_c2_f4_a100 withTextAligment:NSTextAlignmentCenter];
    titleLabel.textColor = [UIColor whiteColor];
    [titleLabel setText:title];
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
}

- (BOOL)playBarHidden {
    return NO;
}

- (BOOL)rightItemHidden {
    return YES;
}

- (BOOL)leftItemHidden {
    return NO;
}

- (MYBaseViewControllerType)inComeType {
    return MYBaseViewControllerTypePush;
}

- (void)viewModelDataChanged {
    if (!self.viewModel) {
        [self.noDataViewManager refreshNoDataEmpty];
        [self showNoData];
        return;
    }
    // 当有数据的时候，显示ViewModelDataChanged
    if ([self.viewModel isKindOfClass:[MYBaseListModel class]]) {
        //TODO: wmy
        MYBaseListModel *listModel = (MYBaseListModel *)self.viewModel;
        if (!listModel.allDataCount) {
            [self.noDataViewManager refreshNoDataEmpty];
            [self showNoData];
        } else {
            self.noDataView.hidden = YES;
        }
    }
    if ([self.viewModel isKindOfClass:[MYBaseViewModel class]]) {
        self.noDataView.hidden = YES;
    }
}

- (void)viewModeStateChanged {
    
}

- (MYBaseViewControllerMode)mode {
    return MYBaseViewControllerModeDefault;
}

- (void)update {
    
}

- (void)showNoData {
    self.noDataView.hidden = NO;
    [self.view bringSubviewToFront:self.noDataView];
}

#pragma mark - 通知

- (void)onChangeNetwork {
    if ([MYBaseNetWorkUtil sharedInstance].status == NotReachable) {
        [self.noDataViewManager refreshNoData];
        [self showNoData];
    } else {
        //TODO: wmy 先这样，之后添加仅WiFi逻辑
        self.noDataView.hidden = YES;
    }
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------

- (void)onRefreshView {
    [self.view setNeedsLayout];
    self.view.backgroundColor = theMYWidget.backgroundColor;
}

#pragma mark MYNoDataViewDelegate

- (void)noDataViewDidClick {
    self.noDataView.hidden = YES;
    [self.viewModel reload];
}

#pragma mark - --------------------属性相关------------------

- (MYNoDataViewManager *)noDataViewManager {
    if (!_noDataViewManager) {
        _noDataViewManager = [MYNoDataViewManager managerWithNoDataView:self.noDataView];
    }
    return _noDataViewManager;
}

- (MYNoDataView *)noDataView {
    if (!_noDataView) {
        _noDataView = [MYNoDataView noDataView];
        _noDataView.delegate = self;
    }
    return _noDataView;
}

- (void)setViewModel:(MYBaseViewModel *)viewModel {
    if (_viewModel) {
        [_viewModel removeObserver:self forKeyPath:kStateKey];
        [_viewModel removeObserver:self forKeyPath:kDataKey];
        [_viewModel cancelRequest];
    }
    
    _viewModel = viewModel;
    if (_viewModel) {
        [_viewModel addObserver:self forKeyPath:kStateKey options:NSKeyValueObservingOptionNew context:nil];
        [_viewModel addObserver:self forKeyPath:kDataKey options:NSKeyValueObservingOptionNew context:nil];
        if (_viewModel.needLoad) {
            [_viewModel beginRequest];
        }
        else{
            [self viewModelDataChanged];
        }
    }
}

@end
