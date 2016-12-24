//
//  MYTopSelectorView.m
//  musixise
//
//  Created by wmy on 2016/11/29.
//  Copyright © 2016年 wmy. All rights reserved.
//

#import "MYTopSelectorView.h"
#import <MYUtils/UIView+MYAdditons.h>
#import "MYTopSelectorLabel.h"

#define kLabelWidth 60
#define kLabelHeight 30
#define kLabelFontSize 12

@interface MYTopSelectorView ()

@property(nonatomic, strong) NSMutableArray<MYTopSelectorModel> *modelArray;
@property(nonatomic, strong) NSMutableArray<MYTopSelectorLabel *> *labelArray;
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, assign) CGFloat maxWidth;
@property(nonatomic, weak) MYTopSelectorLabel *selectLabel;

@end

@implementation MYTopSelectorView

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
    [self addSubview:self.scrollView];
}

+ (instancetype)topSelectorViewWithModels:(NSArray <MYTopSelectorModel> *)modelArray
                                 maxWidth:(CGFloat)width {
    MYTopSelectorView *selectorView = [[MYTopSelectorView alloc] init];
    selectorView.maxWidth = width;
    [selectorView setSelectorArray:modelArray];
    selectorView.width = kLabelWidth * modelArray.count;
    selectorView.height = kLabelHeight;
    return selectorView;
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
}

#pragma mark - --------------------功能函数------------------

- (void)setSelectIndex:(NSInteger)index {
    if (index >= 0 &&
        index < self.modelArray.count) {
        MYTopSelectorLabel *label = [self.labelArray objectAtIndex:index];
        self.selectLabel.selected = NO;
        self.selectLabel = label;
        self.selectLabel.selected = YES;
    }
}

- (void)setSelectorArray:(NSArray *)modelArray {
    [self.modelArray removeAllObjects];
    [self.modelArray addObjectsFromArray:modelArray];
    self.scrollView.height = kLabelHeight;
    CGFloat maxWidth = self.maxWidth;
    self.scrollView.width = kLabelWidth * modelArray.count;
    if (self.scrollView.width > maxWidth) {
        self.scrollView.width = maxWidth;
    }
    for (int i = 0; i < self.modelArray.count; i++) {
        id<MYTopSelectorModel> model = [self.modelArray objectAtIndex:i];
        MYTopSelectorLabel *label = nil;
        if (self.labelArray.count <= i) {
            label = [self newLabelWithModel:model];
        } else {
            label = [self.labelArray objectAtIndex:i];
        }
        label.tag = i;
        label.text = model.title;
        label.textColor = model.normalColor;
        [self.scrollView addSubview:label];
        label.left = kLabelWidth * i;
        UITapGestureRecognizer *labelTap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                  action:@selector(onClickTap:)];
        [label addGestureRecognizer:labelTap];
        [self.labelArray addObject:label];
    }
}

- (MYTopSelectorLabel *)newLabelWithModel:(id<MYTopSelectorModel>)model {
    MYTopSelectorLabel *label = [MYTopSelectorLabel topSelectorLabelWithModel:model];
    //TODO: wmy UI
    label.width = kLabelWidth;
    label.height = kLabelHeight;
    label.userInteractionEnabled = YES;
#if DEBUG
    label.layer.borderWidth = 1;
    label.layer.borderColor = [UIColor redColor].CGColor;
#endif
    return label;
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------

- (void)onClickTap:(UIGestureRecognizer *)recognizer {
    MYTopSelectorLabel *label = (MYTopSelectorLabel *)recognizer.view;
    NSInteger tag = label.tag;
    self.selectLabel = label;
    if ([self.delegate respondsToSelector:@selector(topSelectorViewDidClickIndex:)]) {
        [self.delegate topSelectorViewDidClickIndex:tag];
    }
}

#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

- (void)setSelectLabel:(MYTopSelectorLabel *)selectLabel {
    [_selectLabel setSelected:NO];
    _selectLabel = selectLabel;
    [_selectLabel setSelected:YES];
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (NSMutableArray<MYTopSelectorLabel *> *)labelArray {
    if (!_labelArray) {
        _labelArray = [NSMutableArray<MYTopSelectorLabel *> array];
    }
    return _labelArray;
}

- (NSMutableArray<MYTopSelectorModel> *)modelArray {
    if (!_modelArray) {
        _modelArray = [NSMutableArray<MYTopSelectorModel> array];
    }
    return _modelArray;
}

@end
