//
//  BaseListViewModel.m
//  xiami
//
//  Created by go886 on 14-7-15.
//
//

#import "BaseListViewModel.h"
#import <UIKit/UIKit.h>

@interface BaseListViewModel ()
@property (nonatomic , strong) NSMutableArray* items;
@end

@implementation BaseListViewModel {
    NSMutableIndexSet* _needRemoveSet;
}

-(instancetype)initWithData:(NSArray *)array {
    self = [super init];
    if (self) {
        [self addItems:array];
        self.state = MS_FINISHED;
    }
    return self;
}

-(void)onclear {
    @synchronized(self){
        [_items removeAllObjects];
    }
}
-(NSInteger)itemCount:(NSInteger)section {
    NSInteger count = 0;
    @synchronized(self){
        count = _items ? _items.count : 0;
    }
    return count;
}
-(void)addItems:(NSArray *)items {
    @synchronized(self){
        if (!_items) {
            _items = [NSMutableArray array];
        }
        [_items addObjectsFromArray:items];
    }
    [self emitDataChanged];
}

-(id)data:(NSIndexPath *const)indexPath {
    id returnData = nil;
    @synchronized(self){
        if (_items && indexPath.row < _items.count) {
             returnData = _items[indexPath.row];
        }
    }
    return returnData;
}
-(id)data:(NSIndexPath *const)indexPath key:(NSString *)key {
    id value = [self data:indexPath];
    if ([key isEqualToString:@"data"]) {
        return value;
    }
    if ([value isKindOfClass:[BaseViewModel class]]) {
        return [value data:nil key:key];
    }
    
    @try {
        return [value valueForKey:key];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    return [super data:indexPath key:key];
}

-(NSArray *) allData{
    NSMutableArray * allData = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < _items.count; ++i) {
        id obj = [self data:[NSIndexPath indexPathForRow:i inSection:0]];
        if (obj != nil) {
            [allData addObject:obj];
        }
    }
    return allData;
}

-(NSInteger)allDataCount {
    NSInteger count = 0;
    @synchronized(self){
        count = _items ? _items.count : 0;
    }
    return count;
}

-(void)removeItem:(NSIndexPath *)indexPath{
    if(!indexPath){
        NSAssert(NO, @"indexPath is nil");
        return;
    }
    if (indexPath.row >= [self itemCount:indexPath.section]) {
        NSAssert(NO, @"indexpath is out of range");
        return;
    }
    @synchronized(self){
        [_items removeObjectAtIndex:indexPath.row];
    }
}

//-(void)onUpdateData:(id)data {
//    if (self.isRefreshing) {
//        [self onclear];
//    }
//    if ([data isKindOfClass:[NSArray class]]) {
//        [self addItems:data];
//    }
//}

-(void)onloadFinished:(NSArray*)data nextpage:(NSInteger)nextpage {
    if (self.isRefreshing) {
        [self onclear];
    }
    if ([data isKindOfClass:[NSArray class]]) {
        [self addItems:data];
    }
    
    [self setLoadFinished:YES nextPage:nextpage];
}

-(void)insert:(NSIndexPath* const)indexPath data:(NSArray*)data {
    @synchronized(self){
        if (!_items) {
            _items = [NSMutableArray array];
        }
        [self.items insertObjects:data atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(indexPath.row, [data count])]];
    }
    [self emitDataChanged];
    return;
}

-(void)remove:(NSIndexPath *const)indexPath count:(NSInteger)count {
    [self beginDataChanged];
    @synchronized(self){
        for (NSInteger i = 0; i<count; ++i) {
            if (!_needRemoveSet) _needRemoveSet = [[NSMutableIndexSet alloc] init];
            [_needRemoveSet addIndex:indexPath.row];
        }
    }
    [self endDataChanged];
}

-(void)remove:(NSArray *)indexPathArray {
    [self beginDataChanged];
    NSMutableArray * datas = [NSMutableArray array];
    for (NSIndexPath * index in indexPathArray) {
        id obj = [self data:index];
        if (obj != nil) {
            [datas addObject:obj];
        }
    }
    @synchronized(self){
        [self.items removeObjectsInArray:datas];
    }
    [self endDataChanged];
}

-(void)ondataChanged {
    if (_needRemoveSet && _needRemoveSet.count) {
        @synchronized(self){
            [_needRemoveSet enumerateIndexesWithOptions:NSEnumerationReverse usingBlock:^(NSUInteger idx, BOOL *stop) {
                [_items removeObjectAtIndex:idx];
            }];
            [_needRemoveSet removeAllIndexes];
        }
    }
}

-(void)reset:(NSArray*)data {
    [self beginDataChanged];
     @synchronized(self){
         if (data != nil && [data count] > 0) {
             _items =[NSMutableArray arrayWithArray:data];
         }else{
             _items =[NSMutableArray array];
         }
     }
    self.state = MS_FINISHED;
    [self endDataChanged];
}
@end
