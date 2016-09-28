//
//  MYMoreView.m
//  Pods
//
//  Created by wmy on 16/2/22.
//
//

#import "MYMoreView.h"
#import "MYWidget.h"
#import "UILabel+MYStyle.h"
#import "UIView+MYCurrentViewController.h"

#define kMoreViewTableViewWidth 160
#define kMoreViewTableViewItemHeight 45

@interface MYMoreView () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView *backView;

@end

@implementation MYMoreView

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (instancetype)init {
    if (self = [super init]) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    [self addSubview:self.backView];
    [self addSubview:self.tableView];
}

+ (MYMoreView *)moreViewWithTitleArray:(NSArray *)titleArray top:(CGFloat)top {
    MYMoreView *moreView = [[MYMoreView alloc] init];
    moreView.width = kScreenWidth;
    moreView.height = kScreenHeight;
    moreView.left = 0;
    moreView.top = 0;
    moreView.tableView.top = top;
    moreView.titleArray = titleArray;
    return moreView;
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
    self.tableView.height = self.titleArray.count * kMoreViewTableViewItemHeight;
    self.tableView.right = self.width;
}

#pragma mark - --------------------功能函数------------------

- (void)show {
    self.alpha = 0;
    [[self getCurrentVC].view addSubview:self];
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 100;
    }];
}

- (void)moreViewHidden {
    
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------

#pragma mark UITableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, kMoreViewTableViewItemHeight)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [UILabel labelWithStyle:MYWidgetStyle_MYWidget_tt_c2_f4_a80 withTextAligment:NSTextAlignmentCenter];
    label.text = self.titleArray[indexPath.row];
    [label sizeToFit];
    label.left = theMYWidget.m4;
    label.centerY = kMoreViewTableViewItemHeight * 0.5;
    [cell.contentView addSubview:label];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.width = kMoreViewTableViewWidth - 2 * theMYWidget.m4;
    lineView.height = theMYWidget.seperatorHeight;
    lineView.left = label.left;
    lineView.bottom = kMoreViewTableViewItemHeight;
    lineView.backgroundColor = theMYWidget.seperatorColor;
    [cell.contentView addSubview:lineView];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kMoreViewTableViewItemHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(moreView:didClickIndex:)]) {
        [self.delegate moreView:self didClickIndex:indexPath.row];
    }
    [self moreViewHidden];
}


#pragma mark - --------------------属性相关------------------

- (void)setTitleArray:(NSArray *)titleArray {
    _titleArray = titleArray;
    [self setNeedsLayout];
    [self.tableView reloadData];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.width = kMoreViewTableViewWidth;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.cornerRadius = 5;
        _tableView.separatorStyle = NSUnderlineStyleNone;
        _tableView.backgroundColor = theMYWidget.backgroundColor;
    }
    return _tableView;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.width = kScreenWidth;
        _backView.height = kScreenHeight;
        _backView.backgroundColor = theMYWidget.maskColor;
        _backView.userInteractionEnabled = YES;
        UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                  action:@selector(moreViewHidden)];
        [_backView addGestureRecognizer:backTap];
    }
    return _backView;
}

@end
