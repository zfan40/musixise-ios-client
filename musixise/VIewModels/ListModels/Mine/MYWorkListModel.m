//
//  MYWorkListModel.m
//  musixise
//
//  Created by wmy on 2016/12/25.
//  Copyright © 2016年 wmy. All rights reserved.
//

#import "MYWorkListModel.h"
#import "MYWorkViewModel.h"
#import "MYWorkModel.h"

@implementation MYWorkListModel

- (void)requestSuccess:(NSDictionary *)dict {
    NSArray *array = [dict objectForKey:@"content"];
    NSMutableArray *resultArray = [NSMutableArray array];
    for (NSDictionary *modelDict in array) {
        NSError *error;
        MYWorkModel *workModel = [[MYWorkModel alloc] initWithDictionary:modelDict error:&error];
        MYWorkViewModel *viewModel = [[MYWorkViewModel alloc] initWithData:workModel];
        [resultArray addObject:viewModel];
    }
    [self addItems:resultArray];
}

@end
