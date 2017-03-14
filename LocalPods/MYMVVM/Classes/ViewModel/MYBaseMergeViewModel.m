
//
//  MYBaseMergeModel.m
//  xiaplay
//
//  Created by wmy on 15/12/21.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import "MYBaseMergeViewModel.h"
#import "MYBaseListModel.h"
#import <MYUtils/NSArray+MYSafe.h>

@interface MYBaseMergeViewModel ()

@property (nonatomic,strong) NSMutableArray<MYBaseViewModel *> *models;

@end

@implementation MYBaseMergeViewModel
@synthesize models = _models;


- (void)dealloc {
    for (MYBaseViewModel *m in _models) {
        [m removeObserver:self forKeyPath:kStateKey];
        [m removeObserver:self forKeyPath:kDataKey];
    }
}

- (instancetype)initWithModels:(NSArray<MYBaseViewModel *> *)models {
    if (self = [super init]) {
        [self addModels:models];
    }
    return self;
}

- (void)addModels:(NSArray<MYBaseViewModel *> *)models {
    [self.models addObjectsFromArray:models];
    
    for (MYBaseViewModel *m in models) {
        [m addObserver:self forKeyPath:kStateKey options:NSKeyValueObservingOptionNew context:nil];
        [m addObserver:self forKeyPath:kDataKey options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)beginRequest {
    for (MYBaseViewModel *model in self.models) {
        if ([model isKindOfClass:[MYBaseListModel class]]) {
            MYBaseListModel *listModel = (MYBaseListModel *)model;
            if (listModel.state != STATE_IDLE) {
                return;
            } else {
                [listModel beginRequest];
            }
        } else {
            [model beginRequest];
        }
    }
}

- (void)requestSuccess:(NSDictionary *)dict {
    for (MYBaseViewModel *model in self.models) {
        [model requestSuccess:dict];
    }
}

- (BOOL)more {
    MYBaseViewModel *model = [self.models lastObject];
    return model.more;
}

- (void)requestFailure:(NSError *)error {
    for (MYBaseViewModel *model in self.models) {
        [model requestFailure:error];
    }
}

- (void)refresh {
    for (MYBaseViewModel *model in self.models) {
        [model refresh];
    }
}

- (void)reload {
    for (MYBaseViewModel *model in self.models) {
        [model reload];
    }
}

//- (void)dataBeginChanged {
//    for (MYBaseViewModel *model in self.models) {
//        [model dataBeginChanged];
//    }
//}
//
//- (void)dataEndChanged {
//    for (MYBaseViewModel *model in self.models) {
//        [model dataEndChanged];
//    }
//}

//- (void)emitDateChanged {
//    for (MYBaseViewModel *model in self.models) {
//        [model emitDateChanged];
//    }
//}

- (BOOL)mock {
    for (MYBaseViewModel *model in self.models) {
        if (model.mock) {
            return YES;
        }
    }
    return NO;
}

- (void)cancelRequest {
    for (MYBaseViewModel *model in self.models) {
        [model cancelRequest];
    }
}

- (NSInteger)count {
    return self.models.count;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if ([object isKindOfClass:[MYBaseViewModel class]]) {
        if ([keyPath isEqualToString:kStateKey]) {
//            [self viewModelStateChanged:object];
            //TODO: wmy emitStateChanged
//            [self emitDateChanged];
            return;
        } else if ([keyPath isEqualToString:kDataKey]) {
//            [self viewModelDataChanged:object];
            [self emitDateChanged];
            return;
        }
    }
    
    return [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

- (NSInteger)modelCountWithSection:(NSInteger)section {
    MYBaseViewModel *itemModel = [self.models objectAtIndexForMY:section];
    if ([itemModel isKindOfClass:[MYBaseListModel class]]) {
        return [(MYBaseListModel *)itemModel allDataCount];
    } else if (itemModel) {
        return 1;
    } else {
        return 0;
    }
}

- (void)setModels:(NSArray *)models {
    
}
- (NSArray *)items {
    return self.models;
}
- (NSMutableArray<MYBaseViewModel *> *)models {
    if (!_models) {
        _models = [NSMutableArray array];
    }
    return _models;
}

@end
