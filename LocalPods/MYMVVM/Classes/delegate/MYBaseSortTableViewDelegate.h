//
//  MYBaseSortTableViewDelegate.h
//  xiaplay
//
//  Created by wmy on 15/12/18.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import "MYBaseTableViewDelegate.h"

@protocol BaseSortSectionDelegate <NSObject>
@optional;
- (void)sortSection:(NSInteger)section;

@end

@interface MYBaseSortTableViewDelegate : MYBaseTableViewDelegate

@property (nonatomic,weak) id<BaseSortSectionDelegate> delegate;


@end
