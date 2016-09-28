//
//  MYBaseSortListModel.h
//  xiaplay
//
//  Created by wmy on 15/12/17.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import "MYBaseListModel.h"

@interface MYBaseSortListModel : MYBaseListModel

@property (nonatomic,strong) NSMutableArray *sortArray;
@property (nonatomic,strong) NSMutableArray *indexArray;

- (MYBaseViewModel *)sortViewModelInSection:(NSInteger)section row:(NSInteger)row;

/**
 *  按照拼音进行排序
 */
- (void)sort;

@end
