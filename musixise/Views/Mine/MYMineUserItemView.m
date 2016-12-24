//
//  MYMineUserItemView.m
//  musixise
//
//  Created by wmy on 2016/12/21.
//  Copyright © 2016年 wmy. All rights reserved.
//

#import "MYMineUserItemView.h"
#import <MYUserSystem/MYUser.h>
#import <MYIconFont/MYButtonFactory.h>
#import <MYMVVM/MYBaseTableView.h>
#import <MYMVVM/MYBaseTableViewCell.h>
#import "MYMineUserInfoView.h"
#import "MYMineUserItemModel.h"

#define kImageViewWidth 60
#define kBtnWidth theMYWidget.m5
#define kTableViewCount 4

#define kLeftSpace theMYWidget.m5
#define kTopSpace theMYWidget.m5
#define kInnerSpace 2
#define kLabelSpace theMYWidget.m2
#define kTableviewHeight 30

@interface MYMineUserItemView () <UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UIImageView *iconImageView;
@property(nonatomic, strong) UIButton *masterBtn;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UIButton *genderBtn;
@property(nonatomic, strong) MYBaseTableView *tableView;
@property(nonatomic, strong) NSMutableArray<MYMineUserItemModel *> *tableArray;

@end

@implementation MYMineUserItemView

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
    [self addSubview:self.iconImageView];
    self.iconImageView.width = kImageViewWidth;
    self.iconImageView.height = kImageViewWidth;
    [self addSubview:self.masterBtn];
    self.masterBtn.width = kBtnWidth;
    self.masterBtn.height = kBtnWidth;
    [self addSubview:self.nameLabel];
    
    [self addSubview:self.genderBtn];
    self.genderBtn.width = kBtnWidth;
    self.genderBtn.height = kBtnWidth;
    [self addSubview:self.tableView];
    
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
    self.iconImageView.left = kLeftSpace;
    self.iconImageView.top = kTopSpace;
    CGFloat maxWidth;
    CGFloat leftSpace;
    if (self.masterBtn.hidden) {
        maxWidth = kImageViewWidth + kLeftSpace * 2 - kInnerSpace * 2;
        self.nameLabel.centerY = self.iconImageView.bottom + kLabelSpace + self.nameLabel.height * 0.5;
        self.nameLabel.centerX = maxWidth * 0.5;
    } else {
        maxWidth = kImageViewWidth + kLeftSpace * 2 - self.masterBtn.width - kInnerSpace * 2;
        leftSpace = (kImageViewWidth + kLeftSpace * 2 - self.masterBtn.width - self.nameLabel.width - kInnerSpace) / 2;
        self.masterBtn.left = kInnerSpace;
        self.nameLabel.top = self.iconImageView.bottom + kLabelSpace;
    }
    if (self.nameLabel.width > maxWidth) {
        self.nameLabel.width = maxWidth;
    }
    self.genderBtn.right = self.iconImageView.right;
    self.genderBtn.bottom = self.iconImageView.bottom;
    
    self.tableView.width = self.width - self.iconImageView.right - theMYWidget.m3 - kLeftSpace;
    self.tableView.height = kTableviewHeight * kTableViewCount;
    self.tableView.left = self.iconImageView.right + kLeftSpace;
}

- (void)viewModelDataChanged {
    [super viewModelDataChanged];
    if ([self.viewModel isKindOfClass:[MYUser class]]) {
        [self.tableArray removeAllObjects];
        MYUser *user = (MYUser *)self.viewModel;
        [self.iconImageView my_setImageWithURL:user.largeAvatar];
        self.masterBtn.hidden = !user.isMaster;
        self.nameLabel.text = user.username;
        [self.nameLabel sizeToFit];
        self.genderBtn.hidden = (user.genderType == MYUserGenderTypeUnKnown);
        //TODO: wmy UI
        [MYButtonFactory setButtonImage:self.genderBtn
                          WithimageName:[self genderBtnNameWithType:user.genderType]
                                   size:kBtnWidth
                                  color:theMYWidget.c2];
        for (int i = 0; i < kTableViewCount; i++) {
            MYMineUserItemModel *model = [self.tableArray objectAtIndex:i];
            model.title = [self titleForIndex:i];
            model.detailText = [self detailForIndex:i model:user];
        }
        [self.tableView reloadData];
    }
    [self setNeedsLayout];
}

#pragma mark - --------------------功能函数------------------

- (NSString *)genderBtnNameWithType:(MYUserGenderType)type {
    switch (type) {
        case MYUserGenderTypeMale:
            return [MYIconFont iconNan];
        case MYUserGenderTypeFemale:
            return [MYIconFont iconNv];
        case MYUserGenderTypeUnKnown:
            return @"";
    }
}

- (NSString *)detailForIndex:(NSInteger)index model:(MYUser *)user {
    switch (index) {
        case 0:
            return user.email;
        case 1:
            return user.birth;
        case 2:
            return user.tel;
        case 3:
            return user.nation;
    }
    return @"";
}

- (NSString *)titleForIndex:(NSInteger)index {
    switch (index) {
        case 0:
            return @"Email:";
        case 1:
            return @"Birthday:";
        case 2:
            return @"Tel:";
        case 3:
            return @"Nation:";
    }
    return @"";
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------

#pragma mark UITableViewDelegate,UITableViewDataSource

- (MYBaseTableViewCell *)tableView:(UITableView *)tableView
             cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MYBaseItemView *itemView;
    MYMineUserItemModel *model = [self.tableArray objectAtIndex:indexPath.row];
    MYBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@""];
    if (!cell) {
        itemView = [[MYMineUserInfoView alloc] initWithItemStyle:MYBaseItemViewStyleDefault
                                                       viewModel:model];
        cell = [[MYBaseTableViewCell alloc] initWithItemView:itemView reuseIdentifier:@""];
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kTableviewHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.tableArray.count) {
        return 1;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
#if DEBUG
    NSLog(@"");
#endif
}
#pragma mark - --------------------属性相关------------------

newInstanceUIImageView1(iconImageView)
newInstanceUIButton1(masterBtn)
newInstanceUILabel1(nameLabel, MYWidgetStyle_MYWidget_tt_c2_f3_a80)
newInstanceUIButton1(genderBtn)

- (NSMutableArray <MYMineUserItemModel *>*)tableArray {
    if (!_tableArray) {
        _tableArray = [NSMutableArray arrayWithCapacity:kTableViewCount];
        for (int i = 0; i < kTableViewCount; i++) {
            MYMineUserItemModel *itemModel = [[MYMineUserItemModel alloc] init];
            [_tableArray addObject:itemModel];
        }
    }
    return _tableArray;
}

- (MYBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[MYBaseTableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
#if DEBUG
        _tableView.layer.borderWidth = 1;
        _tableView.layer.borderColor = [UIColor redColor].CGColor;
#endif
    }
    return _tableView;
}

@end
