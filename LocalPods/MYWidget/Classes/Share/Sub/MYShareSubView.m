//
//  MYShareSubView.m
//  Pods
//
//  Created by wmy on 16/10/10.
//
//

#import "MYShareSubView.h"
#import <MYUtils/UIView+MYAdditons.h>
#import "MYShareItem.h"
#import "MYShareModel.h"

#define kItemWidth 70


@interface MYShareSubView ()

@property(nonatomic, strong) NSArray<MYShareModel *> *shareModelArray;
@property(nonatomic, strong) NSMutableArray<MYShareItem *> *shareItemArray;

@end

@implementation MYShareSubView

- (NSMutableArray<MYShareItem *> *)shareItemArray {
    if (!_shareItemArray) {
        _shareItemArray = [NSMutableArray array];
    }
    return _shareItemArray;
}

- (void)setShareModelArray:(NSArray<MYShareModel *> *)shareModelArray {
    if (shareModelArray.count) {
        _shareModelArray = shareModelArray;
        // 根据数据设置自身的宽高
        self.width = shareModelArray.count * kItemWidth;
        self.height = kItemHeight;
        
        for (int i = 0; i < shareModelArray.count; i++) {
            MYShareModel *model = [shareModelArray objectAtIndex:i];
            MYShareItem *item = nil;
            if (self.shareItemArray.count > i) {
                item = [self.shareItemArray objectAtIndex:i];
                [item setShareModel:model];
            } else {
                item = [MYShareItem shareItemWithShareModel:model];
                item.width = kItemWidth;
                item.height = kItemHeight;
                UITapGestureRecognizer *itemTap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                         action:@selector(onClickItem:)];
                [item addGestureRecognizer:itemTap];
                [self.shareItemArray addObject:item];
                [self addSubview:item];
            }
            item.tag = i;
            item.column = i;
            item.left = kItemWidth * i;
        }
    }
}

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

+ (instancetype)shareSubViewWithShareModels:(NSArray <MYShareModel *>*)shareModels {
    MYShareSubView *subView = [[MYShareSubView alloc] init];
    subView.shareModelArray = shareModels;
    return subView;
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
}

#pragma mark - --------------------功能函数------------------
#pragma mark - --------------------手势事件------------------

- (void)onClickItem:(UITapGestureRecognizer *)recoginzer {
    UIView *view = recoginzer.view;
    if ([self.delegate respondsToSelector:@selector(shareSubViewDidClickWithRow:withColumn:)]) {
        [self.delegate shareSubViewDidClickWithRow:view.tag withColumn:self.row];
    }
}

#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------


@end
