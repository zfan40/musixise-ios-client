//
//  MYBaseSortListModel.m
//  xiaplay
//
//  Created by wmy on 15/12/17.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import "MYBaseSortListModel.h"
#import "MYBaseSortViewModel.h"
#import <MYUtils/MYSafeUtil.h>
#import <MYUtils/NSArray+MYSafe.h>

@implementation MYBaseSortListModel




NSInteger sortStringSort(id model1, id model2, void *context)
{
    MYBaseSortViewModel *u1,*u2;
    //类型转换
    u1 = (MYBaseSortViewModel *)model1;
    u2 = (MYBaseSortViewModel *)model2;
    return  [u1.sortedString localizedCompare:u2.sortedString];
}

- (void)sort {
    // 1.获取array
    NSArray *array = [self allData];
    // 2.将pinyin用key，model为value
    for (MYBaseSortViewModel *model in array) {
        NSString *sortedString = [[model.sortedString substringToIndex:1] uppercaseString];
        int asciiCode = [sortedString characterAtIndex:0];
        BOOL isAlpha = (asciiCode <= 90) && (asciiCode >= 65);
        if (isEmptyString(model.sortedString) || !isAlpha) {
            NSDictionary *dict = [self.sortArray objectAtIndexForMY:0];
            NSMutableArray *dictArray = [dict objectForKey:@"#"];
            [dictArray addObject:model];
            continue;
        }
        int sortCode = asciiCode - 65 + 1;
        NSDictionary *sortDict = [self.sortArray objectAtIndexForMY:sortCode];
        NSMutableArray *sortArray = [sortDict objectForKey:sortedString];
        [sortArray addObject:model];
//        DLog(@"sortArray = %@",sortArray);
    }
    // 对于每个array进行排序
    for (int i = 0; i < self.sortArray.count; i++) {
        NSDictionary *dict = [self.sortArray objectAtIndexForMY:i];
        NSMutableArray *dictArray = nil;
        if (i == 0) {
            dictArray = [dict objectForKey:@"#"];
        } else {
            NSString *key = [NSString stringWithFormat:@"%c",(i + 64)];
            dictArray = [dict objectForKey:key];
        }
        [dictArray sortedArrayUsingFunction:sortStringSort context:nil];
    }

}

- (NSArray *)indexArray {
    if (!_indexArray) {
        _indexArray = [NSMutableArray array];
        [_indexArray addObject:@"#"];
        for (int i = 0; i < 26; i++) {
            [_indexArray addObject:[NSString stringWithFormat:@"%c",(i + 65)]];
        }
    }
    return _indexArray;
}

- (NSMutableArray *)sortArray {
    if (!_sortArray) {
        _sortArray = [NSMutableArray array];
        // #
        NSDictionary *dict = @{@"#":[NSMutableArray array]};
        [_sortArray addObject:dict];
        // 新建26个字母的key
        for (int i = 0; i < 26; i++) {
            NSDictionary *dictZimu = @{[NSString stringWithFormat:@"%c",('A' + i)]:[NSMutableArray array]};
            [_sortArray addObject:dictZimu];
        }
    }
    return _sortArray;
}


- (MYBaseViewModel *)sortViewModelInSection:(NSInteger)section row:(NSInteger)row {
    if (!self.sortArray.count || self.sortArray.count < row) {
        return nil;
    }
    NSDictionary *sortDict = [self.sortArray objectAtIndexForMY:section];
    NSArray *array = [[sortDict allValues] objectAtIndexForMY:0];
    return [array objectAtIndexForMY:row];
}

@end
