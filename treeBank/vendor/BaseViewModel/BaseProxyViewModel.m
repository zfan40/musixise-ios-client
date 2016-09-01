//
//  BaseProxyViewModel.m
//  xiami
//
//  Created by go886 on 14-7-12.
//
//

#import "BaseProxyViewModel.h"

@implementation BaseProxyViewModel
-(instancetype)initWithViewModel:(BaseViewModel *)viewModel {
    self = [super init];
    if (self) {
        self.srcViewModel = viewModel;
    }
    return self;
}
-(void)dealloc {
    self.srcViewModel = nil;
}

-(void)setSrcViewModel:(BaseViewModel *)viewModel {
    if (viewModel != _srcViewModel) {
        if (_srcViewModel) {
            [_srcViewModel removeObserver:self forKeyPath:kStateKey context:nil];
            [_srcViewModel removeObserver:self forKeyPath:kDataKey context:nil];
        }
        
        _srcViewModel = viewModel;
        
        if (_srcViewModel) {
            NSAssert([_srcViewModel isKindOfClass:[BaseViewModel class]], @"viewModel error");
            [_srcViewModel addObserver:self forKeyPath:kStateKey options:NSKeyValueObservingOptionNew context:nil];
            [_srcViewModel addObserver:self forKeyPath:kDataKey options:NSKeyValueObservingOptionNew context:nil];
        }
    }
}


-(MODESTATE)state {
    return [_srcViewModel state];
}
-(void)setState:(MODESTATE)state {
    return [_srcViewModel setState:state];
}
-(BOOL)hasMore {
    return [_srcViewModel hasMore];
}
-(BOOL)isLoading {
    return [_srcViewModel isLoading];
}
-(BOOL)isRefreshing {
    return [_srcViewModel isRefreshing];
}
-(NSInteger)size {
    return [_srcViewModel size];
}
-(NSInteger)page {
    return [_srcViewModel page];
}
-(void)load {
    return [_srcViewModel load];
}
-(void)refresh {
    return [_srcViewModel refresh];
}
-(void)cancelLoad {
    return [_srcViewModel cancelLoad];
}
-(void)reload {
    return [_srcViewModel reload];
}
-(void)reset {
    return [_srcViewModel reset];
}
-(void)beginDataChanged {
    return [_srcViewModel beginDataChanged];
}
-(void)endDataChanged {
    return [_srcViewModel endDataChanged];
}
-(void)emitDataChanged {
    return [_srcViewModel emitDataChanged];
}
-(NSInteger)sectionCount {
    return [_srcViewModel sectionCount];
}
-(NSInteger)itemCount:(NSInteger)section {
    return [_srcViewModel itemCount:section];
}
-(id)data:(NSIndexPath* const)indexPath {
    return [_srcViewModel data:indexPath];
}
-(id)data:(NSIndexPath* const)indexPath key:(NSString*)key {
    return [_srcViewModel data:indexPath key:key];
}
-(void)setData:(NSIndexPath* const)indexPath key:(NSString*)key value:(id)value {
    return [_srcViewModel setData:indexPath key:key value:value];
}
-(void)insert:(NSIndexPath* const)indexPath data:(NSArray*)data {
    return [_srcViewModel insert:indexPath data:data];
}
-(void)remove:(NSIndexPath* const)indexPath count:(NSInteger)count {
    return [_srcViewModel remove:indexPath count:count];
}

-(void)bind:(id)obj indexPath:(NSIndexPath*)indexPath keys:(NSArray*)keys keysMap:(NSDictionary*)keysmap {
    return [_srcViewModel bind:obj indexPath:indexPath keys:keys keysMap:keysmap];
}

//
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == _srcViewModel) {
        if ([keyPath isEqualToString:kStateKey]) {
            [self viewModelStateChanged];
            return;
        }else if([keyPath isEqualToString:kDataKey]) {
            [self viewModelDataChanged];
            return;
        }
    }
    
    return [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}
-(void)viewModelStateChanged {
    [self willChangeValueForKey:kStateKey];
    [self didChangeValueForKey:kStateKey];
}
-(void)viewModelDataChanged {
    [self willChangeValueForKey:kDataKey];
    [self didChangeValueForKey:kDataKey];
}
@end
