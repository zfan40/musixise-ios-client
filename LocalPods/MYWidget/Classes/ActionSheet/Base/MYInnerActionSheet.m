//
//  MYInnerActionSheet.m
//  Pods
//
//  Created by wmy on 2017/3/16.
//
//  内部的ActionSheet面板

#import "MYInnerActionSheet.h"
#import <MYUtils/UIView+MYAdditons.h>
#import <MYUtils/MYSafeUtil.h>
#import "MYActionSheetItemModel.h"
#import "MYActionSheetItemView.h"

#define kItemHeight 60
#define kMaxHeight (kScreenHeight * 2 / 3.0)

@interface MYInnerActionSheet () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray<id<MYActionSheetItemModelProtocol>> *itemModels;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MYInnerActionSheet

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
}

+ (void)refreshWidthAndHeight:(MYCustomActionSheet *)actionSheet {
    //TODO: wmy 对tableview根据高度进行限制
    [super refreshWidthAndHeight:actionSheet];
    
}

+ (instancetype)actionSheetWithTitle:(NSString *)title
                             message:(NSString *)message
                            delegate:(id<MYActionSheetDelegate>)delegate
                      itemModelArray:(NSArray<id<MYActionSheetItemModelProtocol>> *)itemModelArray
                   cancelButtonTitle:(NSString *)cancelButtonTitle {
    MYInnerActionSheet *actionSheet = [[MYInnerActionSheet alloc] initWithTitle:title
                                                                     subTitle:message
                                                                   customView:nil
                                                                     delegate:delegate
                                                            cancelButtonTitle:cancelButtonTitle];
    [actionSheet.itemModels addObjectsFromArray:itemModelArray];
    [actionSheet reloadDatas];
    return actionSheet;
}

- (UIView<MYActionSheetContentViewProtocol> *)contentView {
    return self.tableView;
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

#pragma mark - --------------------功能函数------------------

- (void)reloadDatas {
    self.tableView.width = kScreenWidth;
    self.tableView.height = self.itemModels.count * kItemHeight;
    CGFloat totalHeight = self.titleView.height + self.contentView.height + self.bottomView.height;
    if (totalHeight > kMaxHeight) {
        self.tableView.height = kMaxHeight - self.titleView.height - self.bottomView.height;
    }
    [MYInnerActionSheet refreshWidthAndHeight:self];
    [self.tableView reloadData];
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------

#pragma mark UITableViewDataSource,UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MYActionSheetItemModel *itemModel = [self.itemModels objectAtIndex:indexPath.row];
    NSString *iden = [MYActionSheetItemView identifyWithTextAligement:itemModel.textAligement];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    MYActionSheetItemView *itemView;
    if (!cell) {
        itemView = [MYActionSheetItemView actionSheetWithItemModel:itemModel];
        itemView.width = kScreenWidth;
        itemView.height = kItemHeight;
        cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kItemHeight)];
        [cell.contentView addSubview:itemView];
    } else {
        for (UIView *view in cell.contentView.subviews) {
            if ([view isKindOfClass:[MYActionSheetItemView class]]) {
                itemView = view;
                break;
            }
        }
        [itemView setItemModel:itemModel];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemModels.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.itemModels.count) {
        return 1;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(actionSheet:DidClickWithIndex:)]) {
        [self.delegate actionSheet:self.actionSheet DidClickWithIndex:indexPath.row];
    }
}

#pragma mark - --------------------属性相关------------------

- (NSMutableArray<id<MYActionSheetItemModelProtocol>> *)itemModels {
    if (!_itemModels) {
        _itemModels = [NSMutableArray<id<MYActionSheetItemModelProtocol>> array];
    }
    return _itemModels;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

@end
