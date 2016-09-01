//
//  BaseMergeViewModel.m
//  xiami
//
//  Created by go886 on 14-7-15.
//
//

#import "BaseMergeViewModel.h"

@implementation BaseMergeViewModel {
    NSArray* _models;
    __weak BaseViewModel* _lastStateChangedModel;
    __weak BaseViewModel* _lastDataChangedModel;
}

-(instancetype)initWithViewModels:(NSArray *)models {
    NSAssert(models, @"models is null");
    NSAssert(models.count, @"models is empty");
    
    self = [super init];
    if (self) {
        _models = [models copy];
        
        for (BaseViewModel* m in _models) {
            [m addObserver:self forKeyPath:kStateKey options:NSKeyValueObservingOptionNew context:nil];
            [m addObserver:self forKeyPath:kDataKey options:NSKeyValueObservingOptionNew context:nil];
        }
    }
    return self;
}

-(void)dealloc {
    for (BaseViewModel* m in _models) {
        [m removeObserver:self forKeyPath:kStateKey context:nil];
        [m removeObserver:self forKeyPath:kDataKey context:nil];
    }
}

-(BaseViewModel*)modelForSection:(NSInteger)section {
    return [self modelForSection:section outSection:NULL];
}

-(BaseViewModel*)modelForSection:(NSInteger)section outSection:(NSInteger*)outSection {
    NSInteger index = 0;
    for (BaseViewModel* m in _models) {
        NSInteger cnt = [m sectionCount];
        index += cnt;
        if (section < index) {
            if (outSection) *outSection = cnt - (index - section);
            return m;
        }
    }
//    NSAssert(false, @"section not find");
    return nil;
}

-(BOOL)needLoad {
    for (BaseViewModel* m in _models) {
        if (m.needLoad) {
            return YES;
        }
    }
    return FALSE;
}
-(MODESTATE)state {
    BOOL hasFinished = FALSE;
    BOOL hasFailed = FALSE;
    for (BaseViewModel* m in _models) {
        if (m.isLoading) {
            return MS_LOADING;
        }else if(MS_FAILED == m.state) {
            hasFailed = TRUE;
        }else if(MS_FINISHED == m.state) {
            hasFinished = TRUE;
        }
    }
    
    if (hasFinished) {
        return MS_FINISHED;
    }else if(hasFailed) {
        return MS_FAILED;
    }
    return MS_INIT;
}
-(BOOL)isRefreshing {
    for (BaseViewModel* m in _models) {
        if (m.isRefreshing) {
            return true;
        }
    }
    
    return [super isRefreshing];
}

-(NSInteger)page {
    NSInteger page = INT_MAX;
    for (BaseViewModel* m in _models) {
        page = MIN(page, m.page);
    }
    return page;
}

-(NSInteger)size {
    NSInteger size = 0;
    for (BaseViewModel* m in _models) {
        size += m.size;
    }
    return size;
}

-(void)load {
    for (BaseViewModel* m in _models) {
        [m load];
    }
}

-(void)refresh {
    for (BaseViewModel* m in _models) {
        [m refresh];
    }
}
-(void)canelLoad {
    for (BaseViewModel* m in _models) {
        [m cancelLoad];
    }
}
-(void)reset {
    for (BaseViewModel* m in _models) {
        [m reset];
    }
}
-(BOOL)hasMore {
    BOOL bMore = NO;
    for (BaseViewModel* m in _models) {
        BOOL more = [m hasMore];
        if (more) {
            bMore = [m hasMore];
            break;
        }
    }
    return bMore;
}

-(NSInteger)sectionCount {
    NSInteger nRet = 0;
    for (BaseViewModel* m in _models) {
        nRet += [m sectionCount];
    }
    return nRet;
}
-(NSInteger)itemCount:(NSInteger)section {
    NSInteger srcSection;
    BaseViewModel* m = [self modelForSection:section outSection:&srcSection];
    return m ? [m itemCount:srcSection] : [super itemCount:section];
}
-(id)data:(NSIndexPath* const)indexPath key:(NSString*)key {
    NSInteger section;
    BaseViewModel* m = [self modelForSection:indexPath.section outSection:&section];
    if (m) return [m data:makeIndexPath(section, indexPath.row) key:key];
    
    return [super data:indexPath key:key];
}
-(void)setData:(NSIndexPath* const)indexPath key:(NSString*)key value:(id)value {
    NSInteger section;
    BaseViewModel* m = [self modelForSection:indexPath.section outSection:&section];
    if (m) return [m setData:makeIndexPath(section, indexPath.row) key:key value:value];
    
    return [super setData:indexPath key:key value:value];
}
-(void)insert:(NSIndexPath* const)indexPath data:(NSArray*)data {
    NSInteger section;
    BaseViewModel* m = [self modelForSection:indexPath.section outSection:&section];
    if (m) return [m insert:makeIndexPath(section, indexPath.row) data:data];
    
    return [super insert:indexPath data:data];
}
-(void)remove:(NSIndexPath* const)indexPath count:(NSInteger)count {
    NSInteger section;
    BaseViewModel* m = [self modelForSection:indexPath.section outSection:&section];
    if (m) return [m remove:makeIndexPath(section, indexPath.row) count:count];
    
    return [super remove:indexPath count:count];
}

-(void)bind:(id)obj indexPath:(NSIndexPath*)indexPath keys:(NSArray*)keys keysMap:(NSDictionary*)keysmap {
    NSInteger section;
    BaseViewModel* m = [self modelForSection:indexPath.section outSection:&section];
    if (m) return [m bind:obj indexPath:makeIndexPath(section, indexPath.row) keys:keys keysMap:keysmap];
    
    return [super bind:obj indexPath:indexPath keys:keys keysMap:keysmap];
}


//
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([object isKindOfClass:[BaseViewModel class]]) {
        if ([keyPath isEqualToString:kStateKey]) {
            [self viewModelStateChanged:object];
            return;
        }else if([keyPath isEqualToString:kDataKey]) {
            [self viewModelDataChanged:object];
            return;
        }
    }
    
    return [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}
-(BaseViewModel*)lastStateChangedModel {
    return _lastStateChangedModel;
}
-(BaseViewModel*)lastDataChangedModel {
    return _lastDataChangedModel;
}
-(void)viewModelStateChanged:(BaseViewModel*)model {
    [self willChangeValueForKey:kStateKey];
    _lastStateChangedModel = model;
    [self didChangeValueForKey:kStateKey];
}
-(void)viewModelDataChanged:(BaseViewModel*)model {
    [self beginDataChanged];
    _lastDataChangedModel = model;
    [self endDataChanged];
}
@end
