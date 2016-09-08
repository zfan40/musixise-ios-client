//
//  SortFilterProxyViewModel.m
//  xiami
//
//  Created by go886 on 14-7-15.
//
//

#import "PinyinHelper.h"
#import "SortFilterProxyViewModel.h"
#import <objc/message.h>

static NSString *kIdx;
@interface NSIndexPath (x)
@property (assign) NSString *idx;
@end

@implementation NSIndexPath (x)
- (void)setIdx:(NSString *)idx {
    objc_setAssociatedObject(self, &kIdx, idx, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)idx {
    return objc_getAssociatedObject(self, &kIdx);
}
@end

@implementation SortFilterProxyViewModel {
    NSMutableArray *_list;
    NSMutableArray *_keys;

    BOOL _lastEnableConverPinYinFilter;
    BOOL _lastEnableRegExpFileter;
    NSString *_lastPatterns;
    NSArray *_lastFilterKeys;
}
- (instancetype)initWithViewModel:(BaseViewModel *)viewModel {
    self = [super initWithViewModel:viewModel];
    if (self) {
        self.enableConverPinYinFilter = YES;
        self.enableFilterIndexOrdered = NO;

        //        self.enableGroupOrdered = YES;
        //        self.groupOrderedDescending = YES;
        // self.sortedKeys = @[ @"albumName"];
        //        self.orderedDescending = YES;
        //        self.orderedDescending = NO;
        //        self.patterns = @"[宝]";
        //        self.filterKeys = @[@"artistName"];
        //
        //        self.sorter =  ^NSComparisonResult(id v1, id v2, NSString* key) {
        //            if (![key isEqualToString:@"listenCount"]) {
        //                return [v1 compare:v2];
        //            }
        //            NSInteger k1 = [v1 intValue];
        //            NSInteger k2 = [v2 intValue];
        //            if (k1 == k2) {
        //                return NSOrderedSame;
        //            }
        //
        //            if (k1 < k2) {
        //                return NSOrderedAscending;
        //            }
        //            return NSOrderedDescending;
        //        };
        //
        //        self.groupKeys = @[@"artistName"];
        //        self.groupPatterns = @"(a.*)";
    }
    return self;
}
- (NSInteger)size {
    NSInteger itemsCnt = 0;
    for (NSInteger i = 0; i < self.sectionCount; ++i) {
        itemsCnt += [self itemCount:i];
    }
    return itemsCnt;
}
- (NSInteger)sectionCount {
    return _list ? _list.count : 0;
}
- (NSInteger)itemCount:(NSInteger)section {
    if (section < self.sectionCount) {
        return [_list[section] count];
    }
    return 0;
}
- (NSIndexPath *)maptoSource:(NSIndexPath *)index {
    if (index.section < self.sectionCount) {
        NSArray *items = _list[index.section];
        if (index.row < items.count) {
            return items[index.row];
        }
    }
    return nil;
}
- (NSArray *)groups {
    return _keys;
}
- (id)keyForSection:(NSInteger)section {
    NSInteger cnt = (_keys ? _keys.count : 0);
    if (section < cnt) {
        return _keys[section];
    }
    return nil;
}
- (void)setKeyForSection:(NSInteger)section key:(id)key {
    NSInteger cnt = (_keys ? _keys.count : 0);
    if (section < cnt) {
        _keys[section] = key;
    }
}
- (id)data:(NSIndexPath *const)indexPath {
    return [super data:[self maptoSource:indexPath]];
}
- (id)data:(NSIndexPath *const)indexPath key:(NSString *)key {
    if ((0 == indexPath.row) && [@"sectionTitle" isEqualToString:key]) {
        return [self keyForSection:indexPath.section];
    }
    return [super data:[self maptoSource:indexPath] key:key];
}
- (void)setData:(NSIndexPath *const)indexPath key:(NSString *)key value:(id)value {
    return [super setData:[self maptoSource:indexPath] key:key value:value];
}
- (void)insert:(NSIndexPath *const)indexPath data:(NSArray *)data {
    return [super insert:[self maptoSource:indexPath] data:data];
}
- (void)remove:(NSIndexPath *const)indexPath count:(NSInteger)count {
    if (1 >= count)
        return [super remove:[self maptoSource:indexPath] count:count];

    [super beginDataChanged];
    NSMutableDictionary *map = [NSMutableDictionary dictionary];
    for (NSInteger i = 0; i < count; ++i) {
        NSIndexPath *index = makeIndexPath(indexPath.section, indexPath.row + i);
        NSIndexPath *srcIdx = [self maptoSource:index];
        [map setObject:index forKey:srcIdx];
    }
    NSArray *sortedkeys =
        [[map allKeys] sortedArrayWithOptions:NSSortStable
                              usingComparator:^NSComparisonResult(NSIndexPath *idx1, NSIndexPath *idx2) {
                                  return [idx1 compare:idx2];
                              }];
    for (id key in [sortedkeys reverseObjectEnumerator]) {
        [super remove:map[key] count:1];
    }
    [super endDataChanged];
}
- (void)bind:(id)obj indexPath:(NSIndexPath *)indexPath keys:(NSArray *)keys keysMap:(NSDictionary *)keysmap {
    return [super bind:obj indexPath:[self maptoSource:indexPath] keys:keys keysMap:keysmap];
}

- (void)doSortFilter {
    const BOOL needFilter = (_filterKeys && _filterKeys.count && (_filter || _patterns));
    const BOOL needSorted = (_sortedKeys && _sortedKeys.count);
    const BOOL needSplit = (_groupKeys && _groupKeys.count);
    const BOOL needFilterIndexSorted = needFilter & _enableFilterIndexOrdered;

    NSMutableArray *newKeys = nil;
    NSMutableArray *newList = [NSMutableArray array];

    if (needFilter) {
        BOOL bAppend = FALSE;
        if (!_filter && _lastEnableConverPinYinFilter == _enableConverPinYinFilter &&
            _lastEnableRegExpFileter == _enableRegExpFileter && _lastPatterns && [_patterns hasPrefix:_lastPatterns]) {
            if (_lastFilterKeys.count && _lastFilterKeys.count == _filterKeys.count) {
                //                bAppend = TRUE;
                for (NSInteger i = 0; i < _filterKeys.count; ++i) {
                    if (![_lastFilterKeys[i] isEqualToString:_filterKeys[i]]) {
                        bAppend = FALSE;
                        break;
                    }
                }
            }
        }

        SEL sel = @selector(filter:key:);
        NSUInteger (*filterFun)(__strong id, SEL, id, id) =
            (NSUInteger (*)(__strong id, SEL, id, id))(class_getMethodImplementation(self.class, sel));

        if (bAppend) {
            for (NSMutableArray *items in _list) {
                NSMutableArray *sectionItems = [NSMutableArray arrayWithCapacity:items.count];
                [items enumerateObjectsWithOptions:NSEnumerationConcurrent
                                        usingBlock:^(NSIndexPath *index, NSUInteger idx, BOOL *stop) {
                                            int keyIndex = 0;
                                            for (NSString *key in _filterKeys) {
                                                id value = [super data:index key:key];
                                                NSUInteger filterIndex = filterFun(self, sel, value, key);
                                                if (NSNotFound != filterIndex) {
                                                    if (needFilterIndexSorted)
                                                        index.idx =
                                                            [NSString stringWithFormat:@"%d:%lu", keyIndex,
                                                                                       (unsigned long)filterIndex];
                                                    @synchronized(sectionItems) {
                                                        [sectionItems addObject:index];
                                                    }
                                                    break;
                                                }
                                                ++keyIndex;
                                            }
                                        }];

                if (needFilterIndexSorted) {
                    [sectionItems sortWithOptions:NSSortConcurrent
                                  usingComparator:^NSComparisonResult(NSIndexPath *obj1, NSIndexPath *obj2) {
                                      return [obj1.idx compare:obj2.idx];
                                  }];
                }
                [newList addObject:sectionItems];
            }
        } else {
            for (NSInteger i = 0, sectionCnt = [super sectionCount]; i < sectionCnt; ++i) {
                NSInteger itemCnt = [super itemCount:i];
                NSMutableArray *sectionItems = [NSMutableArray arrayWithCapacity:itemCnt];
                dispatch_apply(itemCnt, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^(size_t k) {
                    NSIndexPath *index = makeIndexPath(i, k);
                    int keyIndex = 0;
                    for (NSString *key in _filterKeys) {
                        id value = [super data:index key:key];
                        NSUInteger filterIndex = filterFun(self, sel, value, key);
                        if (NSNotFound != filterIndex) {
                            if (needFilterIndexSorted)
                                index.idx = [NSString stringWithFormat:@"%d:%lu", keyIndex, (unsigned long)filterIndex];
                            @synchronized(sectionItems) {
                                [sectionItems addObject:index];
                            }
                            break;
                        }
                        ++keyIndex;
                    }
                });

                if (needFilterIndexSorted) {
                    [sectionItems sortWithOptions:NSSortConcurrent
                                  usingComparator:^NSComparisonResult(NSIndexPath *obj1, NSIndexPath *obj2) {
                                      return [obj1.idx compare:obj2.idx];
                                  }];
                }
                [newList addObject:sectionItems];
            }
        }

        _lastEnableRegExpFileter = _enableRegExpFileter;
        _lastEnableConverPinYinFilter = _enableConverPinYinFilter;
        _lastPatterns = _patterns;
        _lastFilterKeys = _filterKeys;

    } else {
        for (NSInteger i = 0, sectionCnt = [super sectionCount]; i < sectionCnt; ++i) {
            NSInteger itemCnt = [super itemCount:i];
            NSMutableArray *sectionItems = [NSMutableArray arrayWithCapacity:itemCnt];
            for (NSInteger k = 0; k < itemCnt; ++k) {
                [sectionItems addObject:makeIndexPath(i, k)];
            }
            [newList addObject:sectionItems];
        }
    }

    if (needSplit) {
        SEL sel = @selector(split:key:);
        id (*splitFun)(__strong id, SEL, id, id) =
            (id (*)(__strong id, SEL, id, id))(class_getMethodImplementation(self.class, sel));

        NSMutableArray *keys = [NSMutableArray array];
        NSMutableDictionary *tmpMap = [NSMutableDictionary dictionary];
        for (NSArray *sectionItems in newList) {
            for (NSIndexPath *index in sectionItems) {
                BOOL bFind = FALSE;
                id firstValue = nil;
                for (NSString *key in _groupKeys) {
                    id value = [super data:index key:key];
                    value = splitFun(self, sel, value, key);  //[self split:value key:key];
                    if (value) {
                        NSMutableArray *items = [tmpMap objectForKey:value];
                        if (items) {
                            [items addObject:index];
                            bFind = TRUE;
                            break;
                        } else if (!firstValue) {
                            firstValue = value;
                        }
                    }
                }

                if (!bFind) {
                    NSString *key = (firstValue ? firstValue : @"#");
                    NSMutableArray *items = [tmpMap objectForKey:key];
                    if (!items) {
                        items = [NSMutableArray array];
                        [tmpMap setObject:items forKey:key];
                        [keys addObject:key];
                    }
                    [items addObject:index];
                }
            }
        }

        newKeys = [NSMutableArray array];
        [newList removeAllObjects];
        if (_enableGroupOrdered && !needFilterIndexSorted) {
            [keys sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                NSComparisonResult r = [obj1 compare:obj2];
                if (_groupOrderedDescending) {
                    if (NSOrderedAscending == r) {
                        return NSOrderedDescending;
                    } else if (NSOrderedDescending == r) {
                        return NSOrderedAscending;
                    }
                }
                return r;
            }];
        }

        NSUInteger wellIndex = [keys indexOfObject:@"#"];
        if (NSNotFound != wellIndex) {
            [keys removeObjectAtIndex:wellIndex];
            [keys addObject:@"#"];
        }

        for (id key in keys) {
            [newKeys addObject:key];
            [newList addObject:[tmpMap objectForKey:key]];
        }
    }

    if (needSorted && !needFilterIndexSorted) {
        SEL sortSel = @selector(sort:obj2:);
        NSComparisonResult (*sortFun)(__strong id, SEL, id, id) =
            (NSComparisonResult (*)(__strong id, SEL, id, id))(class_getMethodImplementation(self.class, sortSel));
        for (NSMutableArray *items in newList) {
            [items sortWithOptions:NSSortStable
                   usingComparator:^NSComparisonResult(id obj1, id obj2) {
                       return sortFun(self, sortSel, obj1, obj2);
                   }];
        }
    }

    [self willChangeValueForKey:kDataKey];
    _keys = newKeys;
    _list = newList;
    [self didChangeValueForKey:kDataKey];
}

- (NSComparisonResult)sort:(id)obj1 obj2:(id)obj2 {
    //    NSAssert([NSThread isMainThread], @"only mainThread");
    for (NSString *key in _sortedKeys) {
        id value1 = [super data:obj1 key:key];
        id value2 = [super data:obj2 key:key];
        NSComparisonResult r = _sorter ? _sorter(value1, value2, key) : [value1 compare:value2];
        if (NSOrderedSame == r) {
            continue;
        }

        if (_orderedDescending) {
            if (NSOrderedAscending == r) {
                return NSOrderedDescending;
            } else if (NSOrderedDescending == r)
                return NSOrderedAscending;
        }
        return r;
    }

    return NSOrderedSame;
}

- (NSUInteger)filter:(id)value key:(NSString *)key {
    NSUInteger (^filterImp)(NSString *, id) = ^NSUInteger(NSString *key, id value) {
        if (_filter)
            return _filter(value, key);

        NSStringCompareOptions cmpMask =
            (_enableRegExpFileter ? (NSRegularExpressionSearch | NSCaseInsensitiveSearch) : NSCaseInsensitiveSearch);
        NSString *s =
            [value isKindOfClass:[NSString class]] ? (NSString *)value : [NSString stringWithFormat:@"%@", value];
        //
        if (_enableConverPinYinFilter) {
            NSMutableString *shortedString = [[NSMutableString alloc] init];
            NSString *pinyinstring = [PinyinHelper getPinYin:s shortedPinyin:shortedString withNSString:nil];
            for (NSString *s in @[shortedString, pinyinstring]) {
                NSRange rng = [s rangeOfString:_patterns options:cmpMask];
                if (NSNotFound != rng.location)
                    return rng.location;
            }
        }

        return [s rangeOfString:_patterns options:cmpMask].location;
    };

    if ([value isKindOfClass:[NSArray class]]) {
        for (id v in value) {
            NSUInteger ret = filterImp(key, v);
            if (NSNotFound != ret)
                return ret;
        }
    } else {
        return filterImp(key, value);
    }

    return NSNotFound;
}

- (id)split:(id)value key:(NSString *)key {
    if (_split)
        return _split(value, key);

    NSString *s = [value isKindOfClass:[NSString class]] ? (NSString *)value : [NSString stringWithFormat:@"%@", value];
    if (_groupPatterns) {
        NSRange rng = [s rangeOfString:_groupPatterns options:NSRegularExpressionSearch | NSCaseInsensitiveSearch];
        if (NSNotFound != rng.location) {
            return [s substringWithRange:rng];
        } else {
            return nil;
        }
    }
    if (s) {
        return [[NSString stringWithFormat:@"%c", [PinyinHelper getFirstChar:s]] uppercaseString];
    }
    return value;
}

- (void)viewModelDataChanged {
    if (_lazyDataChanged) {
        [self willChangeValueForKey:kDataKey];
        _keys = nil;
        _list = nil;
        _hasDataChanged = YES;
        [self didChangeValueForKey:kDataKey];
    } else {
        [self apply];
    }
}
- (void)apply {
    if (_hasDataChanged) {
        _hasDataChanged = NO;
    }
    @autoreleasepool {
        [self doSortFilter];
    }
}
@end