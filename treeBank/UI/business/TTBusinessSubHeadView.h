//
//  TTBusinessSubHeadView.h
//  treeBank
//
//  Created by kebi on 16/5/12.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTItemView.h"

#define kClickDealResultSubSort  @"kClickDealResultSubSort"

@interface TTBusinessSubHeadView : UIView
@property(nonatomic, strong) NSArray *datas;
@property (nonatomic, weak) id<TTViewEventProtocal> eventDelegate;
@end
