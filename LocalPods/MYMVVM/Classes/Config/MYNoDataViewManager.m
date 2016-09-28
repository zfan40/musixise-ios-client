//
//  MYViewConfig.m
//  Pods
//
//  Created by wmy on 16/8/28.
//
//

#import "MYNoDataViewManager.h"
#import <MYWidget/MYNoDataView.h>



@interface MYNoDataViewManager ()

@property (nonatomic,weak) MYNoDataView *noDataView;

@property (nonatomic,strong) MYNodataViewModel *noDataModel;
@property (nonatomic,strong) MYNodataViewModel *noDataEmptyModel;
@property (nonatomic,assign) MYNoDataType viewType;
@property (nonatomic,assign) MYNoDataEmptyType viewEmptyType;

@end

@implementation MYNoDataViewManager

+ (instancetype)managerWithNoDataView:(MYNoDataView *)noDataView {
    MYNoDataViewManager *manager = [[MYNoDataViewManager alloc] init];
    manager.noDataView = noDataView;
    return manager;
}

- (void)setViewEmptyType:(MYNoDataEmptyType)type {
    _viewEmptyType = type;
    switch (type) {
        case MYNoDataEmptyType_Empty: {
            self.noDataView.hidden = NO;
            self.noDataEmptyModel.title = @"当前无数据";
            self.noDataEmptyModel.desc = @"可以刷新再试试看哦";
            //TODO: wmy 设置图片
        }
            break;
        case MYNoDataEmptyType_Hidden: {
            self.noDataView.hidden = YES;
        }
            break;
    }
}

- (void)setViewType:(MYNoDataType)type {
    _viewType = type;
    switch (type) {
        case MYNoDataViewType_No_NetWork: {
            self.noDataView.hidden = NO;
            self.noDataModel.title = @"当前无网络";
            self.noDataModel.desc = @"点击再试试看咯";
            //TODO: wmy 设置图片
        }
            break;
        case MYNoDataViewType_Custom: {
            self.noDataView.hidden = NO;
            self.noDataModel.title = @"自定义";
            self.noDataModel.desc = @"自定义";
            //TODO: wmy 设置图片
        }
            break;
        case MYNoDataViewType_Hidden: {
            self.noDataView.hidden = YES;
        }
            break;
    }
}

- (void)refreshNoData {
    [self.noDataView setNoDataViewModel:self.noDataModel];
}

- (void)refreshNoDataEmpty {
    [self.noDataView setNoDataViewModel:self.noDataEmptyModel];
}

- (MYNodataViewModel *)noDataEmptyModel {
    if (!_noDataEmptyModel) {
        _noDataEmptyModel = [[MYNodataViewModel alloc] init];
    }
    return _noDataEmptyModel;
}

- (MYNodataViewModel *)noDataModel {
    if (!_noDataModel) {
        _noDataModel = [[MYNodataViewModel alloc] init];
    }
    return _noDataModel;
}
@end
