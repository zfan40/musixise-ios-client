//
//  TableViewDelegator.m
//  xiami
//
//  Created by go886 on 14-7-27.
//
//

#import "SectionDelegate.h"
#import <objc/message.h>
//#import "BaseViewModel.h"
#import "BaseMergeViewModel.h"
#import "BaseProxyViewModel.h"
//#import "xmNilModel.h"

@implementation BaseSectionDelegate
- (instancetype)init {
    @throw [NSException exceptionWithName:NSGenericException
                                   reason:@"init not supported, use initWithTableView: instead."
                                 userInfo:nil];
    return nil;
}
- (instancetype)initWithTableView:(UITableView *)tableView {
    self = [super init];
    if (self) {
        _tableView = tableView;
    }

    return self;
}

- (void)update {
    [self.tableView reloadData];
}
#pragma UITableViewDelegate
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;  // FALSE cell 不可选中
}
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath;
}
- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath;
}

#pragma UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for
// available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing
// controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = NSStringFromClass([self class]);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.backgroundView = nil;
        // cell.textLabel.text = @"fadsfjalsdkjflajdf";
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
@end

@implementation BaseMergeSectionDelegate {
    NSMutableDictionary *_sectionClsMap;
    NSMutableDictionary *_clsMap;
    NSMutableDictionary *_proxyMap;
}

- (instancetype)initWithTableView:(UITableView *)tableView model:(BaseMergeViewModel *)model {
    self = [self initWithTableView:tableView];
    if (self) {
        _model = model;
    }
    return self;
}

- (void)registerCls:(Class)cls forSection:(NSInteger)section {
    if (!_sectionClsMap)
        _sectionClsMap = [NSMutableDictionary dictionary];
    [_sectionClsMap setObject:NSStringFromClass(cls) forKey:@(section)];
}

- (void)unregisterForSection:(NSInteger)section {
    [_sectionClsMap removeObjectForKey:@(section)];
}

- (void)registerCls:(Class)cls forModel:(Class)modelCls {
    if (!_clsMap)
        _clsMap = [NSMutableDictionary dictionary];
    [_clsMap setObject:NSStringFromClass(cls) forKey:NSStringFromClass(modelCls)];
}
- (void)unregisterForModel:(Class)cls {
    [_clsMap removeObjectForKey:NSStringFromClass(cls)];
}
- (void)unregisterAll {
    [_sectionClsMap removeAllObjects];
    [_clsMap removeAllObjects];
    [_proxyMap removeAllObjects];
}

- (Class)modelClassForSection:(NSInteger)section {
    BaseViewModel *model = [_model modelForSection:section];
    NSAssert(model, @"model is nil");
    while ([model isKindOfClass:[BaseProxyViewModel class]]) {
        model = [(BaseProxyViewModel *)model srcViewModel];
    }

    return [model class];
}

- (XBaseSectionDelegate *)proxy:(NSInteger)section {
    NSString *modelClsName = NSStringFromClass([self modelClassForSection:section]);
    NSString *sectionKey = [NSString stringWithFormat:@"%ld.%@", (long)section, modelClsName];
    XBaseSectionDelegate *result = [_proxyMap objectForKey:sectionKey];
    if (!result) {
        NSString *clsName = [_sectionClsMap objectForKey:@(section)];
        if (!clsName)
            clsName = [_clsMap objectForKey:modelClsName];
        result = [[NSClassFromString(clsName) alloc] initWithTableView:self.tableView model:_model];
        result.sectionIndex = section;
        result.enabledUpdate = FALSE;
        if (result) {
            SectionDelegateCreateBlock block = self.block;
            if (block)
                block(section, result);
            id proxy = [[BaseProxySectionDelegate alloc] initWithTarget:nil proxy:result];
            if (!_proxyMap)
                _proxyMap = [NSMutableDictionary dictionary];
            [_proxyMap setObject:proxy forKey:sectionKey];
            return proxy;
        }
    }

    //    NSAssert(result, @"sectionDelegate is nil");
    return result;
}
- (NSIndexPath *)maptoSource:(NSIndexPath *)index {
    return index;
    // return makeIndexPath([self section:index.section], index.row);
}
- (NSInteger)section:(NSInteger)section {
    return section;
    // return MAX(_sectionIndex - section, 0);
}
#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    [[self proxy:indexPath.section] tableView:tableView
                              willDisplayCell:cell
                            forRowAtIndexPath:[self maptoSource:indexPath]];
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    [[self proxy:section] tableView:tableView willDisplayHeaderView:view forSection:[self section:section]];
}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    [[self proxy:section] tableView:tableView willDisplayFooterView:view forSection:[self section:section]];
}
- (void)tableView:(UITableView *)tableView
    didEndDisplayingCell:(UITableViewCell *)cell
       forRowAtIndexPath:(NSIndexPath *)indexPath {
    [[self proxy:indexPath.section] tableView:tableView
                         didEndDisplayingCell:cell
                            forRowAtIndexPath:[self maptoSource:indexPath]];
}
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    [[self proxy:section] tableView:tableView didEndDisplayingHeaderView:view forSection:[self section:section]];
}
- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section {
    [[self proxy:section] tableView:tableView didEndDisplayingFooterView:view forSection:section];
}

// Variable height support
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self proxy:indexPath.section] tableView:tableView heightForRowAtIndexPath:[self maptoSource:indexPath]];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (0 == [_model itemCount:section] && !_showHeaderWhenEmpty) {
        return 0;
    }
    return [[self proxy:section] tableView:tableView heightForHeaderInSection:[self section:section]];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (0 == [_model itemCount:section] && !_showHeaderWhenEmpty) {
        return 0;
    }
    return [[self proxy:section] tableView:tableView heightForFooterInSection:[self section:section]];
}

// Use the estimatedHeight methods to quickly calcuate guessed values which will allow for fast load times of the table.
// If these methods are implemented, the above -tableView:heightForXXX calls will be deferred until views are ready to
// be displayed, so more expensive logic can be placed there.
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return [[self proxy:indexPath.section] tableView:tableView estimatedHeightForRowAtIndexPath:[self
//    maptoSource:indexPath]];
//}
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
//    return [[self proxy:section] tableView:tableView estimatedHeightForHeaderInSection:[self section:section]];
//}
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
//    return [[self proxy:section] tableView:tableView estimatedHeightForFooterInSection:[self section:section]];
//}

// Section header & footer information. Views are preferred over title should you decide to provide both

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[self proxy:section] tableView:tableView viewForHeaderInSection:[self section:section]];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[self proxy:section] tableView:tableView viewForFooterInSection:[self section:section]];
}
// Accessories (disclosures).  //影响accessoryView
//- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath
//*)indexPath {
//    return [[self proxy:indexPath.section] tableView:tableView accessoryTypeForRowWithIndexPath:[self
//    maptoSource:indexPath]];
//}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    return [[self proxy:indexPath.section] tableView:tableView
            accessoryButtonTappedForRowWithIndexPath:[self maptoSource:indexPath]];
}

// Selection

// -tableView:shouldHighlightRowAtIndexPath: is called when a touch comes down on a row.
// Returning NO to that message halts the selection process and does not cause the currently selected row to lose its
// selected look while the touch is down.
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return
        [[self proxy:indexPath.section] tableView:tableView shouldHighlightRowAtIndexPath:[self maptoSource:indexPath]];
}
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self proxy:indexPath.section] tableView:tableView didHighlightRowAtIndexPath:[self maptoSource:indexPath]];
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if (2147483647 == indexPath.section) {
        return;  // IOS6 下长按会crash
    }
    return
        [[self proxy:indexPath.section] tableView:tableView didUnhighlightRowAtIndexPath:[self maptoSource:indexPath]];
}

// Called before the user changes the selection. Return a new indexPath, or nil, to change the proposed selection.
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self proxy:indexPath.section] tableView:tableView willSelectRowAtIndexPath:[self maptoSource:indexPath]];
}
- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self proxy:indexPath.section] tableView:tableView willDeselectRowAtIndexPath:[self maptoSource:indexPath]];
}
// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self proxy:indexPath.section] tableView:tableView didSelectRowAtIndexPath:[self maptoSource:indexPath]];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self proxy:indexPath.section] tableView:tableView didDeselectRowAtIndexPath:[self maptoSource:indexPath]];
}

// Editing

// Allows customization of the editingStyle for a particular cell located at 'indexPath'. If not implemented, all
// editable cells will have UITableViewCellEditingStyleDelete set for them when the table has editing property set to
// YES.
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return
        [[self proxy:indexPath.section] tableView:tableView editingStyleForRowAtIndexPath:[self maptoSource:indexPath]];
}
- (NSString *)tableView:(UITableView *)tableView
    titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self proxy:indexPath.section] tableView:tableView
        titleForDeleteConfirmationButtonForRowAtIndexPath:[self maptoSource:indexPath]];
}

// Controls whether the background is indented while editing.  If not implemented, the default is YES.  This is
// unrelated to the indentation level below.  This method only applies to grouped style table views.
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self proxy:indexPath.section] tableView:tableView
              shouldIndentWhileEditingRowAtIndexPath:[self maptoSource:indexPath]];
}

// The willBegin/didEnd methods are called whenever the 'editing' property is automatically changed by the table
// (allowing insert/delete/move). This is done by a swipe activating a single row
- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self proxy:indexPath.section] tableView:tableView
                      willBeginEditingRowAtIndexPath:[self maptoSource:indexPath]];
}
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return
        [[self proxy:indexPath.section] tableView:tableView didEndEditingRowAtIndexPath:[self maptoSource:indexPath]];
}

// Moving/reordering

// Allows customization of the target row for a particular row as it is being moved/reordered
- (NSIndexPath *)tableView:(UITableView *)tableView
    targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath
                         toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    return [[self proxy:sourceIndexPath.section] tableView:tableView
                  targetIndexPathForMoveFromRowAtIndexPath:[self maptoSource:sourceIndexPath]
                                       toProposedIndexPath:[self maptoSource:proposedDestinationIndexPath]];
}

// Indentation

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self proxy:indexPath.section] tableView:tableView
                   indentationLevelForRowAtIndexPath:[self maptoSource:indexPath]];
}

// Copy/Paste.  All three methods must be implemented by the delegate.
- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self proxy:indexPath.section] tableView:tableView shouldShowMenuForRowAtIndexPath:indexPath];
}
- (BOOL)tableView:(UITableView *)tableView
 canPerformAction:(SEL)action
forRowAtIndexPath:(NSIndexPath *)indexPath
       withSender:(id)sender {
    return [[self proxy:indexPath.section] tableView:tableView
                                    canPerformAction:action
                                   forRowAtIndexPath:[self maptoSource:indexPath]
                                          withSender:sender];
}
- (void)tableView:(UITableView *)tableView
    performAction:(SEL)action
forRowAtIndexPath:(NSIndexPath *)indexPath
       withSender:(id)sender {
    return [[self proxy:indexPath.section] tableView:tableView
                                       performAction:action
                                   forRowAtIndexPath:[self maptoSource:indexPath]
                                          withSender:sender];
}

#pragma UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self proxy:section] tableView:tableView numberOfRowsInSection:[self section:section]];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for
// available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing
// controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self proxy:indexPath.section] tableView:tableView cellForRowAtIndexPath:[self maptoSource:indexPath]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return MAX(1, _model.sectionCount);
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[self proxy:section] tableView:tableView titleForHeaderInSection:[self section:section]];
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return [[self proxy:section] tableView:tableView titleForFooterInSection:[self section:section]];
}

// Editing

// Individual rows can opt out of having the -editing property set for them. If not implemented, all rows are assumed to
// be editable.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self proxy:indexPath.section] tableView:tableView canEditRowAtIndexPath:[self maptoSource:indexPath]];
}

// Moving/reordering

// Allows the reorder accessory view to optionally be shown for a particular row. By default, the reorder control will
// be shown only if the datasource implements -tableView:moveRowAtIndexPath:toIndexPath:
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self proxy:indexPath.section] tableView:tableView canMoveRowAtIndexPath:[self maptoSource:indexPath]];
}

// Data manipulation - insert and delete support

// After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the
// dataSource must commit the change
- (void)tableView:(UITableView *)tableView
    commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
     forRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self proxy:indexPath.section] tableView:tableView
                                  commitEditingStyle:editingStyle
                                   forRowAtIndexPath:[self maptoSource:indexPath]];
}

// Data manipulation - reorder / moving support

- (void)tableView:(UITableView *)tableView
    moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
           toIndexPath:(NSIndexPath *)destinationIndexPath {
    return [[self proxy:sourceIndexPath.section] tableView:tableView
                                        moveRowAtIndexPath:[self maptoSource:sourceIndexPath]
                                               toIndexPath:[self maptoSource:destinationIndexPath]];
}

@end

///////////////////////
@implementation BaseProxySectionDelegate
- (instancetype)initWithTarget:(id)target proxy:(id)proxy {
    _target = target ? target : [NSNull null];
    _proxy = proxy ? proxy : [NSNull null];
    return self;
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    NSMethodSignature *sig1 = [_proxy methodSignatureForSelector:sel];
    if (sig1)
        return sig1;

    NSMethodSignature *sig2 = [_target methodSignatureForSelector:sel];
    if (sig2)
        return sig2;
    return nil;
}
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    if ([_proxy respondsToSelector:[anInvocation selector]]) {
        [anInvocation invokeWithTarget:_proxy];
        return;
    }
    if ([_target respondsToSelector:[anInvocation selector]]) {
        [anInvocation invokeWithTarget:_target];
        return;
    }
}
- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([_proxy respondsToSelector:aSelector]) {
        return YES;
    }
    if ([_target respondsToSelector:aSelector]) {
        return YES;
    }
    return NO;
}
- (void)dealloc {
    _proxy = nil;
}

@end

/////////////////////////
@implementation BaseSelectSectionDelegate
- (instancetype)initWithTarget:(id)target delegates:(NSArray *)delegates {
    self = [self initWithTarget:target proxy:delegates[0]];
    if (self) {
        _delegates = [delegates copy];
    }
    return self;
}
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    NSInteger cnt = _delegates ? _delegates.count : 0;
    if (_selectedIndex != selectedIndex && selectedIndex < cnt) {
        _selectedIndex = selectedIndex;
        [self setProxy:_delegates[selectedIndex]];
    }
}

- (void)dealloc {
    _delegates = nil;
}

@end

/////////////
@implementation XBaseSectionDelegate
- (instancetype)initWithTableView:(UITableView *)tableView model:(BaseViewModel *)model {
    self = [self initWithTableView:tableView];
    if (self) {
        self.model = model;
        self.enabledUpdate = TRUE;
    }
    return self;
}
- (void)dealloc {
    self.model = nil;
}
- (void)setModel:(BaseViewModel *)model {
    if (_model == model) {
        return;
    }
    if (_model) {
        [_model removeObserver:self forKeyPath:kStateKey];
        [_model removeObserver:self forKeyPath:kDataKey];
        if (model != nil) {
            [_model cancelLoad];
        }
    }

    _model = model;
    if (_model) {
        [_model addObserver:self forKeyPath:kStateKey options:NSKeyValueObservingOptionNew context:nil];
        [_model addObserver:self forKeyPath:kDataKey options:NSKeyValueObservingOptionNew context:nil];
        //        if (_model.needLoad) [_model load];
    }
}
- (BaseViewModel *)sectionModel {
    if ([_model isKindOfClass:[BaseMergeViewModel class]]) {
        return [(BaseMergeViewModel *)_model modelForSection:_sectionIndex];
    }
    return _model;
}
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if (object == _model) {
        if ([keyPath isEqualToString:kStateKey]) {
            [self viewModelStateChanged];
            return;
        } else if ([keyPath isEqualToString:kDataKey]) {
            [self viewModelDataChanged];
            return;
        }
    }

    return [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}
- (void)viewModelStateChanged {
    //
    //    if(self.showNodataTips){
    //        switch (_model.state) {
    //            case MS_INIT:
    //            case MS_LOADING:{
    //                [self.tableView hideNoDataTip];
    //            }
    //                break;
    //            case MS_FINISHED:{
    //                if([self.model isEmpty]){
    //                    [self showNodataViewForState:Nodata_Empty];
    //                }else{
    //                    [self.tableView hideNoDataTip];
    //                }
    //            }
    //                break;
    //            case MS_FAILED:{
    //                NoDataType type = Nodata_Error;
    //                if (![TheRuntime isOnlineMode]) {
    //                    type = NoData_Network;
    //                }
    //                if(![self.model isEmpty]){
    //                    [self.tableView hideNoDataTip];
    //                    return;
    //                }
    //                [self showNodataViewForState:type];
    //            }
    //                break;
    //            default:
    //                NSAssert(nil, @"delegate state error");
    //                break;
    //        }
    //    }
    //
}
- (void)viewModelDataChanged {
    if (self.enabledUpdate)
        [self update];
}
- (void)update {
    return [super update];  //局部刷新暂时有问题去掉
    //    NSIndexSet * nd=[[NSIndexSet alloc]initWithIndex:self.sectionIndex];
    //    [self.tableView reloadSections:nd withRowAnimation:UITableViewRowAnimationAutomatic];
}
#pragma UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    _sectionIndex = section;
    return [self.model itemCount:section];
}

#pragma UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}
- (BOOL)isLastCell:(NSIndexPath *)index {
    return (index.row + 1 == [self tableView:self.tableView numberOfRowsInSection:index.section]);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.model sectionCount];
}
@end
