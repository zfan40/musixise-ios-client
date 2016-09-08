//
//  TableViewDelegator.h
//  xiami
//
//  Created by go886 on 14-7-27.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol SectionDelegate <UITableViewDelegate, UITableViewDataSource>
@end

@interface BaseSectionDelegate : NSObject <SectionDelegate>
- (instancetype)initWithTableView:(UITableView *)tableView;
@property (nonatomic, weak, readonly) UITableView *tableView;

- (void)update;
@end

@interface BaseProxySectionDelegate : NSProxy <SectionDelegate>
- (instancetype)initWithTarget:(id)target proxy:(id)proxy;
@property (nonatomic, weak, readonly) id target;
@property (nonatomic, strong) id proxy;
@end

@interface BaseSelectSectionDelegate : BaseProxySectionDelegate
- (instancetype)initWithTarget:(id)target delegates:(NSArray *)delegates;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, copy, readonly) NSArray *delegates;
@end

@class BaseMergeViewModel;
typedef void (^SectionDelegateCreateBlock)(NSUInteger section, BaseSectionDelegate *delegate);

@interface BaseMergeSectionDelegate : BaseSectionDelegate
- (instancetype)initWithTableView:(UITableView *)tableView model:(BaseMergeViewModel *)model;
- (void)registerCls:(Class)cls forSection:(NSInteger)section;
- (void)unregisterForSection:(NSInteger)section;

- (void)registerCls:(Class)cls forModel:(Class)modelCls;
- (void)unregisterForModel:(Class)modelCls;
- (void)unregisterAll;
@property (nonatomic, strong, readonly) BaseMergeViewModel *model;
@property (nonatomic, copy) SectionDelegateCreateBlock block;
@property (nonatomic, assign) BOOL showHeaderWhenEmpty;
@end

////////////////////////
@class BaseViewModel;
@interface XBaseSectionDelegate : BaseSectionDelegate
- (instancetype)initWithTableView:(UITableView *)tableView model:(BaseViewModel *)model;
@property (nonatomic, strong) BaseViewModel *model;
@property (nonatomic, assign) NSUInteger sectionIndex;
@property (nonatomic, assign) BOOL enabledUpdate;
- (BOOL)isLastCell:(NSIndexPath *)index;
- (BaseViewModel *)sectionModel;

- (void)viewModelStateChanged;
- (void)viewModelDataChanged;
@end
