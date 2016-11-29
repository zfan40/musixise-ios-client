//
//  MYShareContentView.m
//  Pods
//
//  Created by wmy on 16/10/10.
//
//

#import "MYShareContentView.h"
#import <MYUtils/UIView+MYAdditons.h>
#import <MYUtils/UIImage+MYImage.h>
#import "MYShareSubView.h"
#import "MYWidget.h"
#import "MYShareModel.h"

#define kContentViewWidth kScreenWidth
#define kCancelButtonHeight 40

#define kSubViewTag 100

@interface MYShareContentView () <MYShareSubViewDelegate>

@property(nonatomic, strong) NSArray<NSArray<MYShareModel *> *> *shareModelArray;
@property(nonatomic, strong) NSMutableArray<UIScrollView *> *scrollViewArray;
@property(nonatomic, strong) UIButton *cancelButton;

@end

@implementation MYShareContentView


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
    self.backgroundColor = theMYWidget.backgroundColor;
    [self addSubview:self.cancelButton];
    self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.cancelButton setTitleColor:theMYWidget.c2 forState:UIControlStateNormal];
    [self.cancelButton setTitle:@"取 消" forState:UIControlStateNormal];
    [self.cancelButton setBackgroundImage:[UIImage createImageWithColor:theMYWidget.c0 size:CGSizeMake(kContentViewWidth, kCancelButtonHeight)]
                                 forState:UIControlStateHighlighted];
    [self.cancelButton addTarget:self action:@selector(onClickCancel) forControlEvents:UIControlEventTouchUpInside];
    self.cancelButton.width = kContentViewWidth;
    self.cancelButton.height = kCancelButtonHeight;
}

+ (instancetype)shareViewWithModels:(NSArray <NSArray<MYShareModel *> *>*)shareModels {
    MYShareContentView *contentView = [[MYShareContentView alloc] init];
    [contentView setShareModelArray:shareModels];
    return contentView;
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
    self.cancelButton.centerX = self.width * 0.5;
    self.cancelButton.bottom = self.height;
}

#pragma mark - --------------------功能函数------------------
#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------

- (void)onClickCancel {
    if ([self.delegate respondsToSelector:@selector(shareContentViewDidClickCancel)]) {
        [self.delegate shareContentViewDidClickCancel];
    }
}

#pragma mark - --------------------代理方法------------------

#pragma mark MYShareSubViewDelegate

- (void)shareSubViewDidClickWithRow:(NSInteger)row withColumn:(NSInteger)column {
    if (column >= 0 &&
        self.shareModelArray.count > column) {
        NSArray *modelArray = [self.shareModelArray objectAtIndex:column];
        if (row >= 0 &&
            row < modelArray.count) {
            MYShareModel *shareModel = [modelArray objectAtIndex:row];
            if (shareModel.block) {
                shareModel.block();
            }
        }
    }
    if ([self.delegate respondsToSelector:@selector(shareContentViewDidClickCancel)]) {
        [self.delegate shareContentViewDidClickCancel];
    }
}

#pragma mark - --------------------属性相关------------------

newInstanceUIButton1(cancelButton)

- (NSMutableArray<UIScrollView *> *)scrollViewArray {
    if (!_scrollViewArray) {
        _scrollViewArray = [NSMutableArray<UIScrollView *> array];
    }
    return _scrollViewArray;
}

- (void)setShareModelArray:(NSArray<NSArray<MYShareModel *> *> *)shareModelArray {
    if (shareModelArray.count) {
        _shareModelArray = shareModelArray;
        for (int i = 0; i < shareModelArray.count; i++) {
            UIScrollView *scrollView = nil;
            MYShareSubView *subView = nil;
            NSArray<MYShareModel *> *shareModels = [shareModelArray objectAtIndex:i];
            
            if (self.scrollViewArray.count > i) {
                scrollView = [self.scrollViewArray objectAtIndex:i];
                for (UIView *view in scrollView.subviews) {
                    if (view.tag == kSubViewTag) {
                        subView = view;
                        break;
                    }
                }// end-of-for
                if (subView) {
                    [subView setShareModelArray:shareModels];
                }
            } else {
                scrollView = [[UIScrollView alloc] init];
                scrollView.showsHorizontalScrollIndicator = NO;
                scrollView.showsVerticalScrollIndicator = NO;
                subView = [MYShareSubView shareSubViewWithShareModels:shareModels];
                subView.delegate = self;
                subView.tag = kSubViewTag;
                [scrollView addSubview:subView];
                [self addSubview:scrollView];
                scrollView.top = i * kItemHeight + theMYWidget.m3;
                
            }// end of if-else
            subView.row = i;
            scrollView.width = kContentViewWidth;
            scrollView.height = kItemHeight;
            if (subView.width > scrollView.width) {
                scrollView.contentSize = CGSizeMake(subView.width, kItemHeight);
            } else {
                scrollView.contentSize = CGSizeMake(scrollView.width, kItemHeight);
            }
        }
        self.width = kContentViewWidth;
        self.height = kItemHeight * shareModelArray.count + kCancelButtonHeight + theMYWidget.m3;
    }
}

@end
