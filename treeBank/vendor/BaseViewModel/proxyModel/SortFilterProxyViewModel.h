//
//  SortFilterProxyViewModel.h
//  xiami
//
//  Created by go886 on 14-7-15.
//
//

#import "BaseProxyViewModel.h"
#import <Foundation/Foundation.h>

/*
 选择、过滤、分组模型
*/

typedef NSComparisonResult (^sorter)(id v1, id v2, NSString *key);
typedef NSUInteger (^filters)(
    id value, NSString *key);  //返回 指定key过滤后的结果（即搜索出的结果的位置，未搜索到，返回 ：NSNotFound）
typedef id (^groupsplit)(id value, NSString *key);

@interface SortFilterProxyViewModel : BaseProxyViewModel
@property (nonatomic, assign) BOOL orderedDescending;          //指定按降序排序，default = false 即升序
@property (nonatomic, copy) NSArray *sortedKeys;               //指定排序的keys
@property (nonatomic, copy) sorter sorter;                     //自定义排序，默认： @compare 方法排序
@property (nonatomic, strong, readonly) NSArray *indexTitles;  //索引标题
@property (nonatomic, copy) NSString *keyForIndexTitles;       //指定撮索引的key

@property (nonatomic, assign) BOOL enableFilterIndexOrdered;  //指定过滤后的数据是否有序
@property (nonatomic, assign) BOOL enableConverPinYinFilter;  //指定开启按拼音字母过滤
@property (nonatomic, assign) BOOL enableRegExpFileter;       //指定开启按正则方式过滤
@property (nonatomic, copy) NSArray *filterKeys;              //指定过滤的keys
@property (nonatomic, copy)
    NSString *patterns;  //指定过滤的模式串，其与enableConverPinYinFilter 、enableRegExpFileter 有关
@property (nonatomic, copy) filters filter;  //指定自定义的过滤函数，指定后忽略 patterns 参数

@property (nonatomic, assign) BOOL enableGroupOrdered;  //指定开启分组有序
@property (nonatomic, assign)
    BOOL groupOrderedDescending;  //指定按降序分组，需enableGroupOrdered 为yes生效, default = false 即升序
@property (nonatomic, copy) NSArray *groupKeys;       //指定分组的keys
@property (nonatomic, copy) NSString *groupPatterns;  //指定分组的模式串
@property (nonatomic, copy) groupsplit split;  //指定自定义的分组函数，指定后忽略 groupPatterns 参数

@property (nonatomic, assign) BOOL lazyDataChanged;  //延时发送数据通知，合理的使用，可以提交性能, default = false
@property (nonatomic, assign, readonly) BOOL hasDataChanged;  // lazyDataChanged = yes 时， 标识当前数据是否已经变化

- (NSIndexPath *)maptoSource:(NSIndexPath *)index;        //返回原model 中的 indexPath
- (NSArray *)groups;                                      //返回分组信息
- (id)keyForSection:(NSInteger)section;                   //返回指定section 的key名
- (void)setKeyForSection:(NSInteger)section key:(id)key;  //设置指定section 的key名

- (void)apply;  //主动执行选择、过滤、分组等
@end