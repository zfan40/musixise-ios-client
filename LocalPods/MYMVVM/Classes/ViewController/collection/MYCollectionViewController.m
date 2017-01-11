//
//  MYCollectionViewController.m
//  Pods
//
//  Created by wmy on 16/7/26.
//
//

#import "MYCollectionViewController.h"
#import "MYCollectionViewCell.h"
#import <MJRefresh/MJRefresh.h>
#import <MYUtils/UIImage+MYImage.h>

@interface MYCollectionViewController ()

@end

@implementation MYCollectionViewController

#pragma mark - --------------------退出清空------------------

- (void)dealloc {
    InfoLog(@"%@被回收了",[self class]);
}

#pragma mark - --------------------初始化--------------------

- (void)viewDidLoad {
    self.refreshable = YES;
    self.upRefreshable = YES;
    InfoLog(@"%@被创建了",[self class]);
    [super viewDidLoad];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置collectionView滚动方向
    [layout setScrollDirection:[self collectionDirection]];
    
    self.collectionView = [[MYCollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];

    
    if (![self playBarHidden]) {
        self.collectionView.height = self.collectionView.height - [router.navigationController.rootViewController playBar].height;
    }
    
    if (self.refreshable) {
        self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            // 进入刷新状态后调用此block
            DebugLog(@"===================下拉刷新 %@===================",[self class]);
            if ([self.viewModel isKindOfClass:[MYBaseListModel class]]) {
                [(MYBaseListModel *)self.viewModel onClean];
            }
            self.viewModel.page = 1;
            if (self.viewModel.needLoad) {
                [self.viewModel beginRequest];
            } else {
                [self viewModelDataChanged];
            }
        }];
        [self.collectionView.mj_header beginRefreshing];
    } else {
        [self.collectionView.mj_header removeFromSuperview];
    }
    
    if (self.upRefreshable) {
        self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            DebugLog(@"===================上拉加载更多 %@===================",[self class]);
            if (self.viewModel.more) {
                [self.collectionView.mj_footer setAutomaticallyHidden:self.viewModel.more];
                if (self.viewModel.needLoad) {
                    [self.viewModel beginRequest];
                } else {
                    [self viewModelDataChanged];
                }
                [self.collectionView.mj_footer setAutomaticallyHidden:self.viewModel.more];
            } else {
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            }
            
        }];
    } else {
        [self.collectionView.mj_footer removeFromSuperview];
    }
    
    
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.collectionView.height = self.view.height;
}

- (void)viewModelDataChanged {
    [self.collectionView.mj_footer setAutomaticallyHidden:self.viewModel.more];
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
    [self.collectionView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //3.注册collectionViewCell
    [self.collectionView registerClass:[MYCollectionViewCell class] forCellWithReuseIdentifier:self.collectionDelegate.identifier];

    if (self.isBarAlpha) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.shadowImage = [UIImage new];
        self.collectionView.top = 0;
        self.collectionView.height = self.view.height;
    } else {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:theMYWidget.c0]
                                                      forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.shadowImage = [UIImage createImageWithColor:theMYWidget.c0];
        self.collectionView.top = 0;
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nil;
}
#pragma mark - --------------------功能函数------------------

- (UICollectionViewScrollDirection)collectionDirection {
    return UICollectionViewScrollDirectionVertical;
}

- (void)backToTop {
    [self.collectionView scrollsToTop];
}

- (void)back {
    [router routeUrl:@"xiaplay://back"];
}

- (void)collectionDelegateCallBack:(NSDictionary *)dict {
    
}

- (void)setBackItem {
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView setImage:[UIImage imageNamed:@"back"]];
    imageView.width = 40;
    imageView.height = 40;
    [self.navigationItem setBackBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:imageView]];
}
- (void)setTitle:(NSString *)title {
    UILabel *titleLabel = [UILabel labelWithStyle:MYWidgetStyle_MYWidget_tt_c2_f4_a100 withTextAligment:NSTextAlignmentCenter];
    [titleLabel setText:title];
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
    
    UITapGestureRecognizer *myTitleTap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                action:@selector(backToTop)];
    [titleLabel addGestureRecognizer:myTitleTap];
}
#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------



- (void)setCollectionDelegate:(MYBaseCollectionDelegate *)collectionDelegate {
    _collectionDelegate = collectionDelegate;
    self.collectionView.delegate = collectionDelegate;
    self.collectionView.dataSource = collectionDelegate;
    if ([self.navigationController isKindOfClass:[MYNavigationController class]]) {
        collectionDelegate.navigationController = (MYNavigationController *)self.navigationController;
    }
}

@end
