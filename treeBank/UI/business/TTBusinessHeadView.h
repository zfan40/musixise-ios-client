//
//  TTBusinessHeadView.h
//  treeBank
//
//  Created by kebi on 16/5/12.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTItemView.h"
#define kClickDealResultSort  @"kClickDealResultSort"


@interface TTBusinessHeadView : UIView
@property (nonatomic, weak) id<TTViewEventProtocal> eventDelegate;
@end
