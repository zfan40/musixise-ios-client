//
//  MYSortBarView.m
//  xiaplay
//
//  Created by wmy on 15/12/18.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import "MYSortBarView.h"
#import <MYUtils/UIView+MYAdditons.h>
#import <MYUtils/NSArray+MYSafe.h>
  
#import <MYWidget/UILabel+MYStyle.h>

#define kSortButtonTag 225


@interface MYSortBarView ()

@property (nonatomic,strong) UIView *dotView;
@property (nonatomic,strong) NSMutableArray *labelArray;
@property (nonatomic,assign) NSInteger lastIndex;

@end

@implementation MYSortBarView
#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (instancetype)init {
    if (self = [super init]) {
        self.width = 16;
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
    self.lastIndex = 0;
    self.cornerRadius = self.width * 0.5;
    self.borderColor = theMYWidget.c2;
    self.borderWidth = 0.5;
    [self addSubview:self.dotView];
    self.dotView.centerX = self.width * 0.5;
    // 添加手势事件
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
    [self addGestureRecognizer:pan];
    [pan addTarget:self action:@selector(onDrag:)];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                         action:@selector(onClick:)];
    [self addGestureRecognizer:tap];
    self.defaultColor = theMYWidget.c2;
    self.selectColor = theMYWidget.c0;
}
#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------
#pragma mark - --------------------功能函数------------------

- (NSInteger)indexWithPointY:(CGFloat)y {
    NSInteger index = (y - theMYWidget.m3 - theMYWidget.m2) / 16.0;
    if (index >= self.sortArray.count) {
        index = self.sortArray.count - 1;
    } else if (index < 0) {
        index = 0;
    }
    return index;
}

#pragma mark - --------------------手势事件------------------

- (void)onClick:(UIPanGestureRecognizer *)pan {
    CGPoint point = [pan locationInView:self];
    self.index = [self indexWithPointY:point.y];
    UILabel *lastLabel = [self.labelArray objectAtIndexForMY:self.lastIndex];
    lastLabel.textColor = self.defaultColor;
    UILabel *label = [self.labelArray objectAtIndexForMY:self.index];
    label.textColor = self.selectColor;
    self.lastIndex = self.index;
    if ([self.delegate respondsToSelector:@selector(sortBarView:withIndex:)]) {
        [self.delegate sortBarView:self withIndex:self.index];
    }
}

- (void)onDrag:(UIPanGestureRecognizer *)pan {
    CGPoint point =[pan locationInView:self];
    self.index = [self indexWithPointY:point.y];
    UILabel *lastLabel = [self.labelArray objectAtIndexForMY:self.lastIndex];
    lastLabel.textColor = self.defaultColor;
    UILabel *label = [self.labelArray objectAtIndexForMY:self.index];
    label.textColor = self.selectColor;
    self.lastIndex = self.index;
    if ([self.delegate respondsToSelector:@selector(sortBarView:withIndex:)]) {
        [self.delegate sortBarView:self withIndex:self.index];
    }
}

#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

- (void)setIndex:(NSInteger)index {
    _index = index;
    UILabel *lastLabel = [self.labelArray objectAtIndexForMY:self.lastIndex];
    lastLabel.textColor = self.defaultColor;
    UILabel *label = [self.labelArray objectAtIndexForMY:self.index];
    label.textColor = self.selectColor;
    self.lastIndex = self.index;
}

- (NSMutableArray *)labelArray {
    if (!_labelArray) {
        _labelArray = [NSMutableArray array];
    }
    return _labelArray;
}




- (UIView *)dotView {
    if (!_dotView) {
        _dotView = [[UIView alloc] init];
        _dotView.width = theMYWidget.m3;
        _dotView.height = theMYWidget.m3;
        _dotView.cornerRadius = theMYWidget.m2;
        _dotView.centerX = self.width * 0.5;
        _dotView.top = theMYWidget.m2;
        _dotView.backgroundColor = theMYWidget.c2;
    }
    return _dotView;
}

- (void)setSortArray:(NSArray *)sortArray {
    _sortArray = sortArray;
    self.height = 16.0 * (sortArray.count + 2);
    // 清空sortArray,和view中的label
    if (self.labelArray.count) {
        for (UILabel *label in self.labelArray) {
            if (label.superview != nil) {
                [label removeFromSuperview];
            }
        }
    }
    [self.labelArray removeAllObjects];
    for (int i = 0; i < sortArray.count; i++) {
        UILabel *sortLabel = [UILabel labelWithStyle:MYWidgetStyle_MYWidget_tt_c1_f2_a100 withTextAligment:NSTextAlignmentCenter];
        sortLabel.textColor = self.defaultColor;
        sortLabel.textAlignment = NSTextAlignmentCenter;
        sortLabel.font = theMYWidget.f1;
        sortLabel.width = theMYWidget.m3;
        sortLabel.height = 16.0;
        sortLabel.text = [sortArray objectAtIndex:i];
        sortLabel.centerX = self.width * 0.5;
        sortLabel.centerY = 16.0 * (i + 1) + theMYWidget.m2;
        [self addSubview:sortLabel];
        [self.labelArray addObject:sortLabel];
    }
}


@end
