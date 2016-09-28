//
//  MYBaseListModel.h
//  xiaplay
//
//  Created by wmy on 15/11/23.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MYBaseViewModel.h"

#define newInstanceViewModel(viewModelClassName,viewModelName) \
- (viewModelClassName *)viewModelName { \
if (!_##viewModelName) { \
    _##viewModelName = [[viewModelClassName alloc] init]; \
} \
return _##viewModelName; \
}

#define newInstanceViewModelMethod(viewModelClassName,viewModelName,method) \
- (viewModelClassName *)viewModelName { \
if (!_##viewModelName) { \
_##viewModelName = [[viewModelClassName alloc] initWithMethod:method]; \
} \
return _##viewModelName; \
}


@interface MYBaseListModel : MYBaseViewModel
/**
 *  获取所有的数据
 *
 *  @return 数据Array
 */
- (NSArray *)allData;
/**
 *  获取数据的数量
 *
 *  @return count
 */
- (NSInteger)allDataCount;

- (MYBaseViewModel *)data:(NSIndexPath *)indexPath;

- (void)addItems:(NSArray *)array;

- (void)onClean;

- (void)removeItem:(NSIndexPath *)indexPath;

@end
