//
//  SectionToItemProxyViewModel.m
//  xiami
//
//  Created by go886 on 14-7-24.
//
//

#import "SectionToItemProxyViewModel.h"

@implementation SectionToItemProxyViewModel
-(NSIndexPath*)maptoSource:(NSIndexPath*)index {
    return makeIndexPath(index.row, 0);
}

-(NSInteger)size {
    NSInteger itemsCnt = 0;
    for (NSInteger i = 0; i<self.sectionCount; ++i) {
        itemsCnt += [self itemCount:i];
    }
    return itemsCnt;
}

-(NSInteger)sectionCount {
    return 1;
}
-(NSInteger)itemCount:(NSInteger)section {
    return [super sectionCount];
}

-(NSInteger)srcModelItemCount:(NSIndexPath* const)indexPath {
    NSInteger section = indexPath.row;
    return [super itemCount:section];
}

-(id)data:(NSIndexPath* const)indexPath {
    return  [super data:[self maptoSource:indexPath]];
}
-(id)data:(NSIndexPath* const)indexPath key:(NSString*)key {
    return [super data:[self maptoSource:indexPath] key:key];
}
-(void)setData:(NSIndexPath* const)indexPath key:(NSString*)key value:(id)value {
    NSInteger section = indexPath.row;
    NSInteger itemCnt = [super itemCount:section];
    for (NSInteger i =0; i<itemCnt; ++i) {
        [super setData:makeIndexPath(section, i) key:key value:value];
    }
}
-(void)insert:(NSIndexPath* const)indexPath data:(NSArray*)data {
    return [super insert:[self maptoSource:indexPath] data:data];
}
-(void)remove:(NSIndexPath* const)indexPath count:(NSInteger)count {
    [super beginDataChanged];
    for (NSInteger i = count; i > 0; --i) {
        NSInteger section = indexPath.row + i - 1;
        NSInteger itemCnt = [super itemCount:section];
        [super remove:makeIndexPath(section, 0) count:itemCnt];
    }
    [super endDataChanged];
}

-(void)bind:(id)obj indexPath:(NSIndexPath*)indexPath keys:(NSArray*)keys keysMap:(NSDictionary*)keysmap {
    return [super bind:obj indexPath:[self maptoSource:indexPath] keys:keys keysMap:keysmap];
}
@end
