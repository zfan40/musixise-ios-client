//
//  MYBaseViewModel.h
//  xiaplay
//
//  Created by wmy on 15/11/23.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MYUtils/MYDubugLog.h>
#import <MYUtils/MYSafeUtil.h>

typedef void(^RequestCallback)(void);

@class MYBaseModel;
extern NSString* const kStateKey;
extern NSString* const kDataKey;
typedef enum {
    STATE_IDLE = 1,
    STATE_REQUEST = 2,
    STATE_SUCCESS = 3,
    STATE_FAILURE = 4,
} NET_STATE;


@protocol MYBaseViewModel

@end

@interface MYBaseViewModel : NSObject <MYBaseViewModel>

/**
 *  是否还有下一页
 */
@property (nonatomic,assign) BOOL more;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,strong) MYBaseModel *dataModel;
@property (nonatomic,assign) NET_STATE state;
@property (nonatomic,assign) BOOL needLoad;
@property (nonatomic,strong) NSString *method;
@property (nonatomic,strong) NSMutableDictionary *params;

@property (nonatomic,copy) RequestCallback requestCallback;

// 是否为mock数据
@property (nonatomic,assign) BOOL mock;
/**
 *  带method的初始化方法
 *
 *  @param method method
 *
 *  @return 初始化
 */
- (instancetype)initWithMethod:(NSString *)method;

- (instancetype)initWithData:(MYBaseModel *)dataModel;

/**
 *  开始请求
 */
- (void)beginRequest;

- (void)test;
/**
 *  取消请求
 */
- (void)cancelRequest;

/**
 *  请求成功回调(抽象方法，子类实现)
 */
- (void)requestSuccess:(NSDictionary *)dict;
/**
 *  请求失败回调(抽象方法，子类实现)
 */
- (void)requestFailure:(NSError *)error;

/**
 *  上拉加载的时候调用的方法
 */
- (void)refresh;

- (void)reload;

- (void)dataBeginChanged;
- (void)dataEndChanged;
- (void)emitDateChanged;

@end
