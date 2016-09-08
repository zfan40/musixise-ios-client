//
//  ColumnProxyViewModel.m
//  xiami
//
//  Created by go886 on 14-7-12.
//
//

#import "ColumnProxyViewModel.h"
#import <objc/message.h>

@implementation ColumnProxyViewModel {
    NSInteger _columnNum;
}
- (instancetype)initWithViewModel:(BaseViewModel *)viewModel {
    return [[[self class] alloc] initWithViewModel:viewModel columnNum:2];
}
- (instancetype)initWithViewModel:(BaseViewModel *)viewModel columnNum:(NSInteger)columnNum {
    NSAssert(columnNum > 1, @"columnNum error");
    self = [super initWithViewModel:viewModel];
    if (self) {
        _columnNum = MAX(2, columnNum);
    }

    return self;
}

- (NSInteger)itemCount:(NSInteger)section {
    NSInteger itemCnt = [super itemCount:section];
    return itemCnt / _columnNum + (itemCnt % _columnNum ? 1 : 0);
}
- (id)data:(NSIndexPath *const)indexPath key:(NSString *)key {
    if (indexPath.row < [super itemCount:indexPath.section]) {
        return [super data:indexPath key:key];
    }
    return nil;
}

- (void)bind:(id)obj indexPath:(NSIndexPath *)indexPath keys:(NSArray *)keys keysMap:(NSDictionary *)keysmap {
    //    NSAssert(indexPath, @"indexPath is invalid");
    //    NSAssert(obj, @"obj is nil");
    //    NSAssert([obj respondsToSelector:NSSelectorFromString(@"valueForIndex:")], @"valueForIndex: selector
    //    undefine");
    if (!obj || ![obj respondsToSelector:NSSelectorFromString(@"valueForIndex:")]) {
        return;
    }

    SEL sel = NSSelectorFromString(@"valueForIndex:");
    IMP valueForIndex = [obj methodForSelector:sel];
    id (*valueForIndexFun)(__strong id, SEL, NSInteger) = (id (*)(__strong id, SEL, NSInteger))valueForIndex;
    const NSInteger itemCnt = [super itemCount:indexPath.section];
    for (NSInteger i = 0; i < _columnNum; ++i) {
        id itemObj = valueForIndexFun(obj, sel, i);
        const NSInteger row = indexPath.row * _columnNum + i;
        NSIndexPath *srcIndex = makeIndexPath(indexPath.section, row);

        if (row < itemCnt) {
            [itemObj setAlpha:1];
            [self.srcViewModel bind:itemObj indexPath:srcIndex keys:keys keysMap:keysmap];
        } else {
            [itemObj setAlpha:0];
        }
    }
}
@end
