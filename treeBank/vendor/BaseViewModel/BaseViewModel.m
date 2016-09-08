//
//  BaseViewModel.m
//  xiami
//
//  Created by go886 on 14-6-19.
//
//

#import "BaseViewModel.h"

static const NSInteger kInitPageNum = 1;
NSString *const kStateKey = @"state";
NSString *const kDataKey = @"xiami_data";
@implementation BaseViewModel {
    NSInteger dataChangedCnt;
    NSInteger page;
    BOOL isRefreshing;
    BOOL hasMore;
    BOOL sizeing;
}
@synthesize state = _state;
@synthesize minLoadPageNum = _minLoadPageNum;
@synthesize reserveItemNum = _reserveItemNum;
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return nil;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        page = kInitPageNum;
    }

    return self;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)hasMore {
    //    //NSAssert([NSThread isMainThread], @"only mainthread");
    return hasMore;
}
- (NSInteger)page {
    //    //NSAssert([NSThread isMainThread], @"only mainthread");
    return page;
}
- (BOOL)needLoad {
    return MS_FAILED == self.state || MS_INIT == self.state;
}
- (BOOL)isLoading {
    //    //NSAssert([NSThread isMainThread], @"only mainthread");
    return MS_LOADING == self.state;
}
- (BOOL)isRefreshing {
    //    //NSAssert([NSThread isMainThread], @"only mainthread");
    return isRefreshing;
}
- (BOOL)isEmpty {
    return (self.size == 0);
}
- (NSInteger)size {
    // //NSAssert(!sizeing, @"size is circulation");
    sizeing = TRUE;
    NSInteger itemsCnt = 0;
    for (NSInteger i = 0, n = self.sectionCount; i < n; ++i) {
        itemsCnt += [self itemCount:i];
    }
    sizeing = FALSE;
    return itemsCnt;
}
- (void)load {
    //    //NSAssert([NSThread isMainThread], @"only mainthread");
    if (self.isLoading) {
        return;
    } else if (MS_FINISHED == self.state) {
        if (!(self.isRefreshing || self.hasMore)) {
            return;
        }
    }

    self.state = MS_LOADING;
    //[self beginDataChanged];
    [self onload];
}

- (void)refresh {
    //    //NSAssert([NSThread isMainThread], @"only mainthread");
    if (self.isLoading || self.isRefreshing) {
        return;
    }

    isRefreshing = true;
    const NSInteger curpage = page;
    page = kInitPageNum;
    [self load];
    page = curpage;
}

- (void)reload {
    //    //NSAssert([NSThread isMainThread], @"only mainthread");
    if (self.isLoading || self.isRefreshing) {
        return;
    }

    [self beginDataChanged];
    [self reset];
    [self load];
    [self endDataChanged];
}

- (void)setLoadFinished:(BOOL)succeed {
    return [self setLoadFinished:succeed nextPage:0];
}

- (void)setLoadFinished:(BOOL)succeed nextPage:(NSInteger)nextPage {
    //    //NSAssert([NSThread isMainThread], @"only mainthread");
    ////NSAssert(self.isLoading, @"state is error");
    //    NSLog(@"class:%@ setLoadFinished:%d nextPage:%ld page:%ld isRefresh:%d", NSStringFromClass(self.class),
    //    succeed, (long)nextPage, (long)page, self.isRefreshing);
    //  //NSAssert(dataChangedCnt, @"dataChangedCnt error");
    if (isRefreshing) {
        isRefreshing = false;
        if (succeed) {
            page = kInitPageNum;
            // [self onclear];
        }
    }

    if (succeed) {
        hasMore = nextPage > self.page;
        ++page;
        // [self endDataChanged];
    } else {
        //   --dataChangedCnt;
    }

    self.state = succeed ? MS_FINISHED : MS_FAILED;
    if (succeed && self.isEmpty && self.hasMore) {  // 解决第一页数据就为空的情况
        [self load];
    }
}

- (void)cancelLoad {
    // NSAssert([NSThread isMainThread], @"only mainthread");
    if (self.isLoading) {
        [self oncanelLoad];
        self.state = MS_FAILED;
    }
}

- (void)reset {
    // NSAssert([NSThread isMainThread], @"only mainthread");
    [self cancelLoad];
    [self onclear];

    page = kInitPageNum;
    isRefreshing = false;
    hasMore = false;
    self.state = MS_INIT;
    [self emitDataChanged];
}

- (void)onload {
    //    //NSAssert([NSThread isMainThread], @"only mainthread");
    [self setLoadFinished:TRUE];
}
- (void)oncanelLoad {
    //    //NSAssert([NSThread isMainThread], @"only mainthread");
}
- (void)onclear {
    //    //NSAssert([NSThread isMainThread], @"only mainthread");
}
- (void)ondataChanged {
    //     //NSAssert([NSThread isMainThread], @"only mainthread");
}
- (NSInteger)sectionCount {
    //    //NSAssert([NSThread isMainThread], @"only mainthread");
    return 1;
}
- (NSInteger)itemCount:(NSInteger)section {
    //    //NSAssert([NSThread isMainThread], @"only mainthread");
    return 0;
}
- (id)data:(NSIndexPath *const)indexPath {
    // NSAssert(FALSE, @"is null");
    return nil;
}
- (id)data:(NSIndexPath *const)indexPath key:(NSString *)key {
    // NSAssert(FALSE, @"is null key:%@",key);
    return nil;
}
- (void)setData:(NSIndexPath *const)indexPath key:(NSString *)key value:(id)value {
    // NSAssert(FALSE, @"not implementation");
}
- (void)insert:(NSIndexPath *const)indexPath data:(NSArray *)data {
    // NSAssert(FALSE, @"not implementation");
}
- (void)remove:(NSIndexPath *const)indexPath count:(NSInteger)count {
    // NSAssert(FALSE, @"not implementation");
}
- (void)remove:(NSArray *)indexPathArray {
    // NSAssert(FALSE, @"not implementation");
}
- (id)valueForUndefinedKey:(NSString *)key {
    if ([key isEqualToString:kDataKey]) {
        return nil;
    }
#ifdef DEBUG
    return [super valueForUndefinedKey:key];
#endif
    return nil;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
#ifdef DEBUG
    return [super setValue:value forUndefinedKey:key];
#endif
}
- (void)beginDataChanged {
    // NSAssert([NSThread isMainThread], @"only mainthread");
    // NSAssert(dataChangedCnt >= 0, @"dataChangedCnt error class:%@   cnt:%ld", self, (long)dataChangedCnt);
    if (0 == dataChangedCnt++) {
    }
}
- (void)endDataChanged {
    // NSAssert([NSThread isMainThread], @"only mainthread");
    // NSAssert(dataChangedCnt >= 1, @"dataChangedCnt error");
    if (0 >= --dataChangedCnt) {
        // NSAssert(0 == dataChangedCnt, @"dataChangedCnt error");
        [self willChangeValueForKey:kDataKey];
        [self ondataChanged];
        dataChangedCnt = 0;
        [self didChangeValueForKey:kDataKey];
        // NSLog(@"viewModelDataChanged class:%@", NSStringFromClass([self class]));
    }
}
- (void)emitDataChanged {
    // NSAssert([NSThread isMainThread], @"only mainthread");
    [self beginDataChanged];
    [self endDataChanged];
    //    [self willChangeValueForKey:@"data"];
    //    [self didChangeValueForKey:@"data"];
}
- (void)bind:(id)obj indexPath:(NSIndexPath *)indexPath keys:(NSArray *)keys {
    return [self bind:obj indexPath:indexPath keys:keys keysMap:nil];
}
- (void)bind:(id)obj indexPath:(NSIndexPath *)indexPath keys:(NSArray *)keys keysMap:(NSDictionary *)keysmap {
    // NSAssert(obj, @"obj is null");
    // NSAssert([obj respondsToSelector:@selector(setValue:forKey:)], @"obj not NSKeyValueCoding");
    if (obj && [obj respondsToSelector:@selector(setValue:forKey:)]) {
        for (NSString *key in keys) {
            NSString *key2 = [keysmap objectForKey:key];
            if (!key2)
                key2 = key;
            @try {
                [obj setValue:[self data:indexPath key:key] forKey:key2];
            } @catch (NSException *exception) {
                NSLog(@"ep:%@", exception);
            } @finally {
            }
        }
    }
}
- (void)each:(void (^)(NSIndexPath *index))block {
    if (block) {
        for (NSInteger i = 0; i < self.sectionCount; ++i) {
            for (NSInteger row = 0; row < [self itemCount:i]; ++row) {
                block(makeIndexPath(i, row));
            }
        }
    }
}
- (void)echoForKey:(NSString *)key {
    [self each:^(NSIndexPath *index) {
        NSLog(@"section:%ld row:%ld key:%@ data:%@", (long)index.section, (long)index.row, key,
              [self data:index key:key]);
    }];
}
- (void)preloadForView:(UIView *)v {
    if (![v isKindOfClass:[UIScrollView class]]) {
        return;
    }
    if (self.reserveItemNum == 0) {
        return;
    }
    UIScrollView *scrollView = (UIScrollView *)v;

    int y = scrollView.contentOffset.y;
    int h = scrollView.contentSize.height;
    int height = scrollView.frame.size.height - 100;
    if (h > 0 && y + height + 60 > h) {
        [self load];
        return;
    }

    if (!self.isLoading) {
        const NSInteger sectionCnt = [self sectionCount];
        const NSInteger reserveCnt = self.reserveItemNum;

        for (NSInteger i = 0, k = -1; i < sectionCnt; ++i) {
            k += [self itemCount:i];
            if (k >= reserveCnt) {
                return;
            }
        }
        [self load];
    }
}
@end

NSIndexPath *makeIndexPath(NSUInteger section, NSUInteger row) {
    NSUInteger indexes[] = {section, row};
    NSIndexPath *indexPath = [[NSIndexPath alloc] initWithIndexes:indexes length:2];
    return indexPath;
}
