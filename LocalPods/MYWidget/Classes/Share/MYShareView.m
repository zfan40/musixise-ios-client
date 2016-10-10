//
//  MYShareView.m
//  Pods
//
//  Created by wmy on 16/10/10.
//
//

#import "MYShareView.h"
#import <MYUtils/UIView+MYAdditons.h>
#import <MYUtils/MYDubugLog.h>
#import "MYShareSubView.h"
#import "MYWidget.h"
#import "MYShareModel.h"
#import "MYShareContentView.h"
#import "MYMaskView.h"

@interface MYShareView () <MYMaskViewDelegate,MYShareContentViewDelegate>

@property(nonatomic, strong) MYMaskView *maskView;

@property(nonatomic, strong) MYShareContentView *contentView;

@end

@implementation MYShareView


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
    [self addSubview:self.maskView];
    self.maskView.width = kScreenWidth;
    self.maskView.height = kScreenHeight;
    self.maskView.delegate = self;
}

+ (instancetype)shareViewWithModels:(NSArray <NSArray<MYShareModel *> *>*)shareModels {
    MYShareView *view = [[MYShareView alloc] init];
    view.width = kScreenWidth;
    view.height = kScreenHeight;
    [view setShareModelArray:shareModels];
    return view;
}


- (void)setShareModelArray:(NSArray<NSArray<MYShareModel *> *> *)shareModelArray {
    if (shareModelArray.count) {
        if (self.contentView) {
            [self.contentView setShareModelArray:shareModelArray];
        } else {
            self.contentView = [MYShareContentView shareViewWithModels:shareModelArray];
            self.contentView.delegate = self;
            [self addSubview:self.contentView];
        }
    } else {
        DebugLog(@"shareModelArray.count = 0");
    }
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

#pragma mark - --------------------功能函数------------------

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.maskView.alpha = 0;
    self.contentView.top = kScreenHeight;
    [UIView animateWithDuration:0.35 animations:^{
        self.contentView.bottom = self.bottom;
        self.maskView.alpha = 1;
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.35 animations:^{
        self.maskView.alpha = 0;
        self.contentView.top = kScreenHeight;
    } completion:^(BOOL finished) {
        if (self.superview) {
            [self removeFromSuperview];
        }
    }];
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------

#pragma mark MYMaskViewDelegate

- (void)maskViewDidClick {
    [self dismiss];
}

#pragma mark MYShareContentViewDelegate

- (void)shareContentViewDidClickCancel {
    [self dismiss];
}

#pragma mark - --------------------属性相关------------------

- (MYMaskView *)maskView {
    if (!_maskView) {
        _maskView = [MYMaskView maskView];
        _maskView.alpha = 0;
    }
    return _maskView;
}

@end
