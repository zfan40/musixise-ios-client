//
//  XAnimationController.h
//  xiami
//
//  Created by kebi on 14/11/28.
//  Copyright (c) 2014年 xiami. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol TTViewControllerAnimatedTransitioning <UIViewControllerAnimatedTransitioning>
@end
@interface TTAnimationController : NSObject <TTViewControllerAnimatedTransitioning>
@property (nonatomic, assign) BOOL isPositiveAnimation;
@end
