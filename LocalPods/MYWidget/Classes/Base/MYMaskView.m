//
//  MYMaskView.m
//  Pods
//
//  Created by wmy on 16/10/10.
//
//

#import "MYMaskView.h"
#import "MYWidget.h"

@implementation MYMaskView

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
    self.backgroundColor = theMYWidget.maskColor;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                         action:@selector(onClick)];
    [self addGestureRecognizer:tap];
}

+ (instancetype)maskView {
    MYMaskView *maskView = [[MYMaskView alloc] init];
    return maskView;
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
}

#pragma mark - --------------------功能函数------------------
#pragma mark - --------------------手势事件------------------

- (void)onClick {
    if ([self.delegate respondsToSelector:@selector(maskViewDidClick)]) {
        [self.delegate maskViewDidClick];
    }
}

#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

@end
