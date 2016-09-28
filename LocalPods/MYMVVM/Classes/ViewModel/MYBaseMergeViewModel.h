//
//  MYBaseMergeModel.h
//  xiaplay
//
//  Created by wmy on 15/12/21.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import "MYBaseViewModel.h"

@interface MYBaseMergeViewModel : MYBaseViewModel

- (instancetype)initWithModels:(NSArray<MYBaseViewModel *> *)models;
- (void)addModels:(NSArray<MYBaseViewModel *> *)models;
//TODO: wmy 删除model
- (NSInteger)count;
- (NSInteger)modelCountWithSection:(NSInteger)section;
- (NSArray *)items;
@end
