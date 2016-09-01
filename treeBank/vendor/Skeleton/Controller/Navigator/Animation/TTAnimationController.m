//
//  XAnimationController.m
//  xiami
//
//  Created bykebi on 14/11/28.
//  Copyright (c) 2014年 xiami. All rights reserved.
//

#import "TTAnimationController.h"
#define kTTPushTransitionTime 0.35

@implementation TTAnimationController

@synthesize isPositiveAnimation = _isPositiveAnimation;

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return kTTPushTransitionTime;
}
@end
