//
//  MYDetailMultiTableViewController.m
//  Pods
//
//  Created by wmy on 16/7/26.
//
//

#import "MYDetailMultiTableViewController.h"
#import <MYUtils/UIView+MYAdditons.h>

#define kSegmentViewControllerViewTag 326

@interface MYDetailMultiTableViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UIImageView *backImageView;
@property (nonatomic,strong) MYSegmentViewController *segmentViewController;

@end

@implementation MYDetailMultiTableViewController

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view insertSubview:self.backImageView belowSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.segmentViewController.view.tag = kSegmentViewControllerViewTag;
    [self addChildViewController:self.segmentViewController];
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tableView.bounces = YES;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)viewModelDataChanged {
    [super viewModelDataChanged];
    [self setChildViewControllKeyValues];
}

#pragma mark - --------------------功能函数------------------

- (BOOL)upRefreshable {
    return NO;
}

- (BOOL)refreshable {
    return NO;
}

- (BOOL)isBarAlpha {
    return YES;
}

- (UIView *)headerView {
    return nil;
}

- (CGFloat)headerHeight {
    return 120;
}

- (NSDictionary *)addKeyValues {
    return nil;
}

- (void)setChildViewControllKeyValues {
    NSDictionary *dict = [self addKeyValues];
    if (dict.allKeys.count) {
        for (MYBaseViewController *baseVC in self.segmentViewController.childViewControllers) {
            for (NSString *key in dict) {
                [baseVC setValue:[dict objectForKey:key] forKey:key];
            }
        }
    }
}

/**
 *  添加子ViewController
 *
 *  @param vierControllers viewcontrollers
 */
- (void)addViewControllers:(NSArray <MYSegmentModel *> *)viewControllers {
    [self.segmentViewController setArray:viewControllers];
    [self setChildViewControllKeyValues];
}

///**
// *  点击第(index - 1)个tab回调
// *
// *  @param index index
// */
//- (void)detailMultiTableViewControllerDidClickIndex:(NSInteger)index {
//    
//}
//
///**
// *  双击第(index - 1)个回调
// *
// *  @param index index
// */
//- (void)detailMultiTableViewControllerDidDoubleClickIndex:(NSInteger)index {
//    
//}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------

#pragma mark TableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MYBaseTableViewCell *cell = [[MYBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    cell.backgroundColor = [UIColor clearColor];
    if (indexPath.row == 0) {
        [cell.contentView addSubview:[self headerView]];
    } else {
        [cell.contentView addSubview:self.segmentViewController.view];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return [self headerHeight];
    } else {
        return kScreenHeight - 64 - 50;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 将headerView悬停
    if (scrollView.contentOffset.y > 64) {
        scrollView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    }else {
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    CGFloat height = [self headerHeight];
    CGFloat y = scrollView.contentOffset.y + 64;
    if (y < 0) {
        y = 0;
    }
    if (y > height) {
        y = height;
    }
    CGFloat alpha = 100.0 / height * y / 100.0;
    if (alpha > 1) {
        alpha = 1;
    }
    if (scrollView.contentOffset.y <= 0) {
        alpha = 0;
    }
    if (alpha < 0) {
        alpha = 0;
    }
//    UIImage *backgroundImage = [UIImage createImageWithColor:RGBA(245, 50, 115, alpha)];
//    [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = backgroundImage;
    
//    if (self.viewController) {
//        [self.viewController tableDelegateCallBack:@{@"offsetY":@(scrollView.contentOffset.y + 64)}];
//    }
}

#pragma mark - --------------------属性相关------------------

- (MYSegmentViewController *)segmentViewController {
    if (!_segmentViewController) {
        _segmentViewController = [[MYSegmentViewController alloc] init];
        __block MYDetailMultiTableViewController *wSelf = self;
        _segmentViewController.block = ^{
            return [wSelf addKeyValues];
        };
    }
    return _segmentViewController;
}

- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.width = kScreenWidth;
        _backImageView.backgroundColor = [UIColor purpleColor];
        _backImageView.height = [self headerHeight] + 100;
    }
    return _backImageView;
}

@end
