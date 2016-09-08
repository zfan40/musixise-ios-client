//
//  BaseViewModel.h
//  xiami
//
//  Created by go886 on 14-6-19.
//
//

#import "BaseViewModelLib.h"
#import "MTLJSONAdapter.h"
#import "MTLModel.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
 模型状态
*/
typedef enum {
    MS_INIT = 0,  //默认状态
    MS_LOADING,   //加载中状态
    MS_FINISHED,  //加载完成状态
    MS_FAILED     //加载失败
} MODESTATE;

extern NSString *const kStateKey;
extern NSString *const kDataKey;
@protocol ViewModelDelegate <NSObject>
@property (nonatomic, assign) MODESTATE state;
@property (nonatomic, assign) NSUInteger minLoadPageNum;  // 指定 model 最小加载的数据页数，default = 0
@property (nonatomic, assign) NSUInteger reserveItemNum;  // 指定 model 预加载保留的数据条数

/*
 指定分页加载中，是否还有下页
 default = false
*/
- (BOOL)hasMore;

/*
 指定model 是否需要加载数据
*/
- (BOOL)needLoad;

/*
 是否正在加载中
*/
- (BOOL)isLoading;

/*
 是否正在刷新中
*/
- (BOOL)isRefreshing;

/*
 指定 model 是否为空
 等同于 0 == size();
*/
- (BOOL)isEmpty;

/*
 model 大小
*/
- (NSInteger)size;

/*
 当前页数，默认从 1 开始
*/
- (NSInteger)page;

/*
 加载数据，其内部会调用onload 方法去实现加载数据
 可重复调用
 注意：其与reload 、refresh的区别，参见refresh
*/
- (void)load;

/*
 刷新数据
 注意：其与load 、reload的区别
 refresh:  其内部会调用load方法，如果load成功，则替换旧数据，否则，不作任何操作
*/
- (void)refresh;

/*
 取消加载
 子类需要实现oncancelLoad 方法来取消请求
 内部会设置state为 MS_FAILED
*/
- (void)cancelLoad;

/*
 重新加载
 注意：其与load 、refresh的区别，参见refresh
*/
- (void)reload;

/*
 重置 模型，使模型恢复初使状态
*/
- (void)reset;

/*
 开始改变数据
 其必需与endDataChanged 成对出现
 exp:
    [model beginDataChanged];
    [model setData:xxxx];
    [model enDataChanged];
*/
- (void)beginDataChanged;

/*
 结束数据改变
 参见：beginDataChanged
*/
- (void)endDataChanged;

/*
 提交数据改变，发送datachanged 通知
 等同于：
    [model beginDataChanged];
    [model enDataChanged];
*/
- (void)emitDataChanged;

- (void)each:(void (^)(NSIndexPath *index))block;
- (void)echoForKey:(NSString *)key;

/*
 预加载
*/
- (void)preloadForView:(UIView *)v;

/*
 返回 section 个数
*/
- (NSInteger)sectionCount;

/*
 返回 section 中item 个数
*/
- (NSInteger)itemCount:(NSInteger)section;

/*
 返回 指定indexPath 的数据
 等同于 [self data:indexPath key:@"data"];
*/
- (id)data:(NSIndexPath *const)indexPath;
- (id)data:(NSIndexPath *const)indexPath key:(NSString *)key;

/*
 修改 指定indexPath、key 的数据为value
 修改成功后发送dataChanged 消息
*/
- (void)setData:(NSIndexPath *const)indexPath key:(NSString *)key value:(id)value;

/*
 在indexPath 后插入数据
 一般用于listViewModel
*/
- (void)insert:(NSIndexPath *const)indexPath data:(NSArray *)data;

/*
 移除 从indexPath 开始的数据
 count 为移除的条数
*/
- (void)remove:(NSIndexPath *const)indexPath count:(NSInteger)count;

/*
 移除 indexPathArray 指定数据
*/
- (void)remove:(NSArray *)indexPathArray;

/*
 绑定model数据 到obj中，基于KV机制
 obj: 绑定的目标对象
 keys: 绑定的属性
 keysMap:  key 为obj的属性，value 为model中的key, 可为空
*/
- (void)bind:(id)obj indexPath:(NSIndexPath *)indexPath keys:(NSArray *)keys;
- (void)bind:(id)obj indexPath:(NSIndexPath *)indexPath keys:(NSArray *)keys keysMap:(NSDictionary *)keysmap;
@end

@interface BaseViewModel : MTLModel <ViewModelDelegate, MTLJSONSerializing>
- (void)setLoadFinished:(BOOL)succeed;
- (void)setLoadFinished:(BOOL)succeed nextPage:(NSInteger)nextPage;
- (void)onload;
- (void)oncanelLoad;
- (void)onclear;
- (void)ondataChanged;
@end

extern NSIndexPath *makeIndexPath(NSUInteger section, NSUInteger row);
