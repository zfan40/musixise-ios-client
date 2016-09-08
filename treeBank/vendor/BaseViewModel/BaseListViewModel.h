//
//  BaseListViewModel.h
//  xiami
//
//  Created by go886 on 14-7-15.
//
//

#import "BaseViewModel.h"
#import <Foundation/Foundation.h>

@interface BaseListViewModel : BaseViewModel
- (instancetype)initWithData:(NSArray *)array;

- (void)addItems:(NSArray *)items;
- (void)removeItem:(NSIndexPath *)indexPath;
- (NSArray *)allData;
- (NSInteger)allDataCount;
- (void)onloadFinished:(NSArray *)data nextpage:(NSInteger)nextpage;

//替换数据;
- (void)reset:(NSArray *)data;
@end
