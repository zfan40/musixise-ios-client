//
//  MYBaseViewModel.m
//  xiaplay
//
//  Created by wmy on 15/11/23.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import "MYBaseViewModel.h"
#import "MYBaseNetWorkUtil.h"
#import "MYBaseModel.h"
#import <objc/objc.h>
#import <objc/runtime.h>
#import <AFNetworking/AFHTTPRequestOperation.h>

typedef struct objc_property *objc_property_t;

@interface MYBaseViewModel ()

@property (nonatomic,strong) AFHTTPRequestOperation *operation;

@end

@implementation MYBaseViewModel
NSString* const kStateKey = @"baseViewModelstate";
NSString* const kDataKey = @"xiaplay_data";

#pragma mark - --------------------退出清空------------------



#pragma mark - --------------------初始化--------------------

- (instancetype)init {
    if (self = [super init]) {
        // 初始化状态
        [self initData];
    }
    return self;
}

- (instancetype)initWithData:(MYBaseModel *)dataModel {
    if (self = [self init]) {
        self.dataModel = dataModel;
    }
    return self;
}

- (instancetype)initWithMethod:(NSString *)method {
    if (self = [super init]) {
        self.method = method;
    }
    return self;
}

- (void)initData {
    self.needLoad = YES;
    self.more = YES;
    self.state = STATE_IDLE;
    self.page = 1;
}

#pragma mark - --------------------属性相关------------------
#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------

//- (NSString *)description {
//    unsigned int count;
//    
//    // 获取类的所有属性
//    // 如果没有属性，则count为0，properties为nil
//    objc_property_t *properties = class_copyPropertyList([self class], &count);
//    NSMutableString *string = [NSMutableString string];
//    for (NSUInteger i = 0; i < count; i++) {
//        // 获取属性名称
//        const char *propertyName = property_getName(properties[i]);
//        NSString *name = [NSString stringWithUTF8String:propertyName];
//        id propertyValue = [self valueForKey:name];
//        [string appendString:[NSString stringWithFormat:@"%@\t\t%@\n",name,propertyValue]];
//    }
//    // 注意，这里properties是一个数组指针，是C的语法，
//    // 我们需要使用free函数来释放内存，否则会造成内存泄露
//    free(properties);
//    
//    return string;
//}
//


- (id)valueForUndefinedKey:(NSString *)key {
    if ([key isEqualToString:kDataKey] || [key isEqualToString:kStateKey]) {
        return nil;
    }
#ifdef DEBUG
    return [super valueForUndefinedKey:key];
#endif
    return nil;
}


#pragma mark - --------------------功能函数------------------


- (void)beginRequest {
    self.state = STATE_REQUEST;
    [self dataBeginChanged];
        [self request];
}

- (void)test {
    
}

/**
 *  开始请求
 */
- (void)request {
    if (self.mock) {
        [self test];
        self.more = NO;
        [self dataEndChanged];
        return;
    }
    if (!self.page) {
        self.page = 1;
    }
    [self.params setObject:@(self.page) forKey:@"page"];
    [self.params setObject:@(20) forKey:@"limit"];
    self.operation = [[MYBaseNetWorkUtil sharedInstance] gethttpWithDictionary:self.params
                                                   withMethod:self.method
                                                 withComplete:^(NSDictionary * _Nonnull dict, BOOL success, NSError * _Nonnull error) {
                                                     if (!error) {
                                                         if (success) {
                                                             self.more = [[dict objectForKey:@"more"] boolValue];
                                                             if (self.more) {
                                                                 self.page++;
                                                             }
//                                                             DebugLog(@"result = %@",dict);
                                                             [self onRequestSuccess:dict];
                                                             self.state = STATE_SUCCESS;
                                                             if (self.requestCallback) {
                                                                 self.requestCallback();
                                                             }
                                                         }
                                                     } else {
                                                         DebugLog(@"error = %@",error.domain);
                                                         [self emitDateChanged];
                                                         [self onRequestFailure:error];
                                                         self.state = STATE_FAILURE;
                                                         if (self.requestCallback) {
                                                             self.requestCallback();
                                                         }
                                                     }
    }];
}

- (void)onRequestSuccess:(NSDictionary *)dict {
    [self requestSuccess:dict];
    [self dataEndChanged];
    
}

- (void)onRequestFailure:(NSError *)error {
    [self requestFailure:error];
    [self dataEndChanged];
}

- (void)refresh {
    // 2. 重新请求
    if (self.state == STATE_REQUEST) {
        // 说明正在请求中
        return;
    }
    [self request];
}

- (void)reload {
    [self dataBeginChanged];
    [self request];
}

- (void)dataBeginChanged {
    [self willChangeValueForKey:kDataKey];
}

- (void)dataEndChanged {
    [self didChangeValueForKey:kDataKey];
}

- (void)emitDateChanged {
    [self dataBeginChanged];
    [self dataEndChanged];
}

/**
 *  请求成功回调
 */
- (void)requestSuccess:(NSDictionary *)dict {
}
/**
 *  请求失败回调
 */
- (void)requestFailure:(NSError *)error {
    
}

/**
 *  取消请求
 */
- (void)cancelRequest {
    // 取消请求
    self.state = STATE_IDLE;
    if (self.operation) {
        [self.operation cancel];
    }
    
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------

- (void)setDataModel:(MYBaseModel *)dataModel {
    _dataModel = dataModel;
    NSDictionary *dict = [_dataModel modelDictionary];
    if (_dataModel && dict.allKeys.count) {
        for (NSString *key in dict.allKeys) {
            id value = [dict objectForKey:key];
            if (key && value) {
                @try {
                    [self setValue:value forKey:key];
                }
                @catch (NSException *exception) {
                    DebugLog(@"exception = %@",exception);
                }
                @finally {
                    
                }
            }
        }
    }
}

- (BOOL)needLoad {
    _needLoad = (self.state != STATE_REQUEST);
    return _needLoad;
}

- (NSMutableDictionary *)params {
    if (!_params) {
        _params = [NSMutableDictionary dictionary];
    }
    return _params;
}

@end
