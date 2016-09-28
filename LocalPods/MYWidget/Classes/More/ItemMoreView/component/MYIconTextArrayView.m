//
//  MYIconTextArrayView.m
//  Pods
//
//  Created by wmy on 16/4/13.
//
//

#import "MYIconTextArrayView.h"
#import "MYIconTextItem.h"
#import <MYWidget/MYWidget.h>
#import "MYItemMoreViewModel.h"
#define MYItemItemViewTag 100


@interface MYIconTextArrayView ()

@property (nonatomic,assign) NSInteger column;
@property (nonatomic,assign) CGFloat itemWidth;
@property (nonatomic,strong) NSArray<MYItemMoreViewModel> *iconArray;
@property (nonatomic,strong) NSMutableArray<MYIconTextItem *> *itemViewArray;
@property (nonatomic,assign) NSInteger totalRow;
@end

@implementation MYIconTextArrayView

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
    self.column = 4;
}

+ (instancetype)iconTextArrayViewWithArray:(NSArray <MYItemMoreViewModel>*)array column:(NSInteger)column {
    MYIconTextArrayView *iconTextArrayView = [[MYIconTextArrayView alloc] init];
    iconTextArrayView.column = column;
    iconTextArrayView.iconArray = array;
    return iconTextArrayView;
}
#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)updateItemViewWithItemView:(MYIconTextItem *)itemView{
    NSInteger index = itemView.tag - MYItemItemViewTag;
    NSInteger row = index / self.column;
    NSInteger column = index % self.column;
    
    CGFloat width = self.itemWidth;
    CGFloat height = 58;
    itemView.width = width;
    itemView.height = height;
    itemView.left = column * width;
    itemView.top = row * height;
}

#pragma mark - --------------------功能函数------------------

- (void)updateIcon:(NSString *)iconFont withIndex:(NSInteger)index {
    MYIconTextItem *iconTextItem = [self.itemViewArray objectAtIndex:index];
    [iconTextItem updateIconFont:iconFont];
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

- (void)setColumn:(NSInteger)column {
    if (column) {
        _column = column;
    }
}
- (void)setIconArray:(NSArray<MYItemMoreViewModel> *)iconArray {
    _iconArray = iconArray;
    self.totalRow = iconArray.count / self.column;
    CGFloat itemWidth = (self.totalRow == 0) ? (kScreenWidth / self.iconArray.count) : (kScreenWidth / self.column);
    self.itemWidth = itemWidth;
    self.width = self.column * itemWidth;
    self.height = (self.totalRow + 1) * 58;
    
    // 删除子Item
    for (UIView *iconView in self.subviews) {
        [iconView removeFromSuperview];
    }
    
    [self.itemViewArray removeAllObjects];
    
    NSInteger column = self.column;
    if (iconArray.count < self.column) {
        column = iconArray.count;
    }
    
    NSInteger index = 0;
    for (id<MYItemMoreViewModel> moreViewModel in iconArray) {
        MYIconTextItem *itemView = [MYIconTextItem itemMoreViewItemViewWithIconfont:moreViewModel.iconFont
                                                                              title:moreViewModel.title];
        itemView.tag = MYItemItemViewTag + index;
        [self updateItemViewWithItemView:itemView];
        [self.itemViewArray addObject:itemView];
        itemView.userInteractionEnabled = YES;
        [self addSubview:itemView];
        UITapGestureRecognizer *itemViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                  action:moreViewModel.selMothod];
        [itemView addGestureRecognizer:itemViewTap];
        index++;
    }
}


@end
