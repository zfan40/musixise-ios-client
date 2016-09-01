//
//  DetailToListProxyModel.m
//  xiami
//
//  Created by go886 on 14-7-29.
//
//

#import "DetailToListProxyViewModel.h"
#import <UIKit/UIKit.h>
#import <objc/message.h>

@implementation DetailToListProxyViewModel {
    NSMutableArray* _items;
}
-(NSInteger)size {
    return _items ? _items.count : 0;
}
-(NSInteger)sectionCount {
    return 1;
}
-(NSInteger)itemCount:(NSInteger)section {
    return self.size;
}

-(id)data:(NSIndexPath* const)indexPath {
    if (indexPath && indexPath.row < self.size) {
        return _items[indexPath.row];
    }
    
    return nil;
}
-(id)data:(NSIndexPath* const)indexPath key:(NSString*)key {
    return [self data:indexPath];
}

-(void)bind:(id)obj indexPath:(NSIndexPath*)indexPath keys:(NSArray*)keys keysMap:(NSDictionary*)keysmap {
    Class granny = [[self superclass] superclass];
    IMP grannyImp = class_getMethodImplementation(granny, _cmd);
    void (*func)(__strong id,SEL, id, id, id, id) = (void (*)(__strong id, SEL, id, id, id, id))grannyImp;
    func(self, _cmd, obj, indexPath, keys,keysmap);
    return;
}

-(void)rebuild {
    NSMutableArray* newItems = [NSMutableArray array];
    for (NSInteger i =0, sectionCnt = [super sectionCount]; i<sectionCnt; ++i) {
        for (NSInteger k=0, itemCnt = [super itemCount:i]; k<itemCnt; ++k) {
            NSIndexPath* index = makeIndexPath(i, k);
            NSInteger n = 0;
            for (NSString* key in _keys) {
                id value = [super data:index key:key];
                if (value) {
                    if (_formats && n < _formats.count) {
                        value = [NSString stringWithFormat:_formats[n], value];
                    }
                }else {
                    if (_defaultValues && n < _defaultValues.count) {
                        value = _defaultValues[n];
                    }
                }
                if (value) {
                    [newItems addObject:value];
                }
                ++n;
            }
        }
    }
    
    [self willChangeValueForKey:kDataKey];
    _items = newItems;
    [self didChangeValueForKey:kDataKey];
}
-(void)viewModelDataChanged {
    [self rebuild];
}

-(void)apply {
    [self rebuild];
}
@end
