
//
//  XCornerScanLayer.m
//  musixise
//
//  Created by wmy on 2017/4/17.
//  Copyright © 2017年 wmy. All rights reserved.
//

#import "MYCornerScanLayer.h"
#import <MYWidget/MYWidget.h>
#import <MYUtils/CALayer+MYAdditions.h>

#define kStickWidth 2

@interface MYCornerScanLayer ()

@property (nonatomic, strong) CALayer *verticalLayer;
@property (nonatomic, strong) CALayer *horizontalLayer;

@end

@implementation MYCornerScanLayer


- (instancetype)init {
    if (self = [super init]) {
        [self initLayer];
    }
    return self;
}

- (instancetype)initWithLayer:(id)layer {
    if (self = [super initWithLayer:layer]) {
        [self initLayer];
    }
    return self;
}

- (void)initLayer {
    [self addSublayer:self.verticalLayer];
    [self addSublayer:self.horizontalLayer];
    self.position = CGPointMake(0.5, 0.5);
}

- (void)layoutSublayers {
    [super layoutSublayers];
    self.horizontalLayer.width = self.width;
    self.verticalLayer.height = self.height;
}

+ (instancetype)cornerScanLayer {
    MYCornerScanLayer *layer = [[MYCornerScanLayer alloc] init];
    
    return layer;
}

- (CALayer *)horizontalLayer {
    if (!_horizontalLayer) {
        _horizontalLayer = [[CALayer alloc] init];
        _horizontalLayer.backgroundColor = theMYWidget.c0.CGColor;
        _horizontalLayer.height = kStickWidth;
    }
    return _horizontalLayer;
}

- (CALayer *)verticalLayer {
    if (!_verticalLayer) {
        _verticalLayer = [[CALayer alloc] init];
        _verticalLayer.backgroundColor = theMYWidget.c0.CGColor;
        _verticalLayer.width = kStickWidth;
    }
    return _verticalLayer;
}

@end
