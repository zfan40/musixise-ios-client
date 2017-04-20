//
//  XScanView.m
//  musixise
//
//  Created by wmy on 2017/4/17.
//  Copyright © 2017年 wmy. All rights reserved.
//

#import "MYScanView.h"
#import <MYUtils/CALayer+MYAdditions.h>
#import <MYUtils/UIView+MYAdditons.h>
#import <MYWidget/MYWidget.h>
#import <QuartzCore/QuartzCore.h>
#import "MYCornerScanLayer.h"
#import "MYCenterScanView.h"

#define kCornerWidth 20

@interface MYScanView ()

@property (nonatomic, strong) MYCornerScanLayer *leftTopScanLayer;
@property (nonatomic, strong) MYCornerScanLayer *rightTopScanLayer;
@property (nonatomic, strong) MYCornerScanLayer *leftBottomScanLayer;
@property (nonatomic, strong) MYCornerScanLayer *rightBottomScanLayer;

@property (nonatomic, strong) MYCenterScanView *scanView;

@property(nonatomic, assign) BOOL isStart;

@end

@implementation MYScanView


#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    [self.layer addSublayer:self.leftTopScanLayer];
    [self.layer addSublayer:self.rightTopScanLayer];
    [self.layer addSublayer:self.leftBottomScanLayer];
    [self.layer addSublayer:self.rightBottomScanLayer];
    [self addSubview:self.scanView];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}
#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

- (void)layoutSubviews {
    [super layoutSubviews];
    self.rightTopScanLayer.right = self.width;
    self.leftBottomScanLayer.bottom = self.height;
    self.rightBottomScanLayer.right = self.width;
    self.rightBottomScanLayer.bottom = self.height;
    
    self.scanView.width = self.width;
    
    self.scanView.left = 0;
}

#pragma mark - --------------------功能函数------------------

- (void)startAnimation {
    self.isStart = YES;
    [self doAnimation];
}

- (void)doAnimation {
    if (self.isStart) {
        [self animation];
    }
}

- (void)animation {
    [UIView animateWithDuration:3.0f animations:^{
        self.scanView.top = self.height;
    } completion:^(BOOL finished) {
        self.scanView.top = 0;
        [self performSelector:@selector(doAnimation) withObject:nil afterDelay:0.5];
    }];
}

- (void)stopAnimation {
    self.isStart = NO;
}

#pragma mark private

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

- (MYCenterScanView *)scanView {
    if (!_scanView) {
        _scanView = [[MYCenterScanView alloc] init];
        _scanView.height = 2;
    }
    return _scanView;
}

- (MYCornerScanLayer *)leftTopScanLayer {
    if (!_leftTopScanLayer) {
        _leftTopScanLayer = [MYCornerScanLayer cornerScanLayer];
        _leftTopScanLayer.width = kCornerWidth;
        _leftTopScanLayer.height = kCornerWidth;
    }
    return _leftTopScanLayer;
}

- (MYCornerScanLayer *)rightTopScanLayer {
    if (!_rightTopScanLayer) {
        _rightTopScanLayer = [MYCornerScanLayer cornerScanLayer];
        _rightTopScanLayer.width = kCornerWidth;
        _rightTopScanLayer.height = kCornerWidth;
        CATransform3D rotate = CATransform3DMakeRotation(M_PI/2, 0, 0, 1);
        _rightTopScanLayer.transform = CATransform3DRotate(rotate, 0, 0, 0, 1);
    }
    return _rightTopScanLayer;
}

- (MYCornerScanLayer *)leftBottomScanLayer {
    if (!_leftBottomScanLayer) {
        _leftBottomScanLayer = [MYCornerScanLayer cornerScanLayer];
        _leftBottomScanLayer.width = kCornerWidth;
        _leftBottomScanLayer.height = kCornerWidth;
        CATransform3D rotate = CATransform3DMakeRotation(-M_PI/2, 0, 0, 1);
        _leftBottomScanLayer.transform = CATransform3DRotate(rotate, 0, 0, 0, 1);

    }
    return _leftBottomScanLayer;
}

- (MYCornerScanLayer *)rightBottomScanLayer {
    if (!_rightBottomScanLayer) {
        _rightBottomScanLayer = [MYCornerScanLayer cornerScanLayer];
        _rightBottomScanLayer.width = kCornerWidth;
        _rightBottomScanLayer.height = kCornerWidth;
        CATransform3D rotate = CATransform3DMakeRotation(M_PI, 0, 0, 1);
        _rightBottomScanLayer.transform = CATransform3DRotate(rotate, 0, 0, 0, 1);

    }
    return _rightBottomScanLayer;
}

@end
