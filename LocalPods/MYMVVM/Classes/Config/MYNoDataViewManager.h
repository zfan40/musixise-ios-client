//
//  MYViewConfig.h
//  Pods
//
//  Created by wmy on 16/8/28.
//
//

#import <Foundation/Foundation.h>
@class MYNoDataView;

typedef enum {
    MYNoDataViewType_No_NetWork = 0,
    MYNoDataViewType_Custom = 1,
    MYNoDataViewType_Hidden,
} MYNoDataType;

typedef enum {
    MYNoDataEmptyType_Empty = 0,
    MYNoDataEmptyType_Hidden = 1,
} MYNoDataEmptyType;


@interface MYNoDataViewManager : NSObject

+ (instancetype)managerWithNoDataView:(MYNoDataView *)noDataView;

- (void)setViewType:(MYNoDataType)type;

- (void)setViewEmptyType:(MYNoDataEmptyType)type;

- (void)refreshNoData;
- (void)refreshNoDataEmpty;

@end
