//
//  MYBaseNetWorkUtil.m
//  xiaplay
//
//  Created by wmy on 15/11/25.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import "MYBaseNetWorkUtil.h"
#import <Reachability/Reachability.h>
#import <AFNetworking/AFURLSessionManager.h>
#import <MYUtils/MYSafeUtil.h>
#import "AFHTTPRequestOperationManager.h"
#import "MYBaseNetWorkTool.h"
#import "MYPhoneUtil.h"
#import <MYUtils/NSArray+ALMSafe.h>
#import <MYUtils/MYDubugLog.h>



//TODO: wmy 加密
#define API_KEY @"655bdb5fc1e0d21a53fce2cb8e1ba0ae"
#define API_SECRET @"1fb9ebd12bec2db8c250e1fae9b37ca6"

#define kFormalAddress @"http://api.musixise.com/api"
//#define kImageUploadAddress @"http://upload.xiami.com"

@interface MYBaseNetWorkUtil ()

@property (nonatomic,strong) AFHTTPRequestOperationManager *manager;
@property (nonatomic,assign) MYNetWorkStatus status;

@end

@implementation MYBaseNetWorkUtil


#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------

- (instancetype)init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onChangeNetwork)
                                                     name:kReachabilityChangedNotification
                                                   object:nil];
    }
    return self;
}

#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------
#pragma mark - --------------------功能函数------------------

- (NSString *)urlAddressWithDictionary:(NSDictionary *)dict {
    NSString *address = kFormalAddress;
    NSMutableString *str = [NSMutableString string];
    [str appendString:address];
    [str appendString:@"?"];
    NSArray *allKeys = dict.allKeys;
    for (int i = 0; i < allKeys.count; i++) {
        if (i != 0) {
            [str appendString:@"&"];
        }
        [str appendString:[allKeys objectAtIndexForALM:i]];
        [str appendString:@"="];
        [str appendString:[dict objectForKey:[allKeys objectAtIndexForALM:i]]];
    }
        return str;
}


- (AFHTTPRequestOperation *_Nullable)gethttpWithDictionary:(nonnull NSDictionary *)dict
                                                       url:(NSString * _Nonnull)url
                                              withComplete:(void (^ _Nonnull)(NSDictionary *_Nonnull result, BOOL success, NSError *_Nullable error))block {
    AFHTTPRequestOperation *operation = [self.manager GET:url parameters:dict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        DebugLog(@"================== success ==================");
        NSDictionary *responseDict = (NSDictionary *)responseObject;
        if (block) {
            NSError *error = nil;
            block(responseDict,YES,error);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        DebugLog(@"================== failure  ==================");
        DebugLog(@"error = %@;",error);
        if (block) {
            block(nil,NO,error);
        }
    }];
    return operation;

}



- (AFHTTPRequestOperation *)gethttpWithDictionary:(nonnull NSDictionary *)dict withMethod:(NSString *)method withComplete:(void (^)(NSDictionary *, BOOL, NSError *))block {
    //TODO: wmy 添加仅wifi
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    [paramDict setObject:method forKey:@"method"];
    [paramDict addEntriesFromDictionary:dict];
    // 系统参数 begin
    paramDict = [self systemParams:paramDict];
    // 系统参数 end
    DebugLog(@"\rrequestParams = %@",paramDict);
    AFHTTPRequestOperation *operation = [self.manager GET:kFormalAddress parameters:paramDict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        DebugLog(@"================== success ==================");
        NSDictionary *responseDict = (NSDictionary *)responseObject;
        NSDictionary *data = [responseObject objectForKey:@"data"];
        NSInteger state = [[responseDict objectForKey:@"state"] integerValue];
        NSString *message = [responseDict objectForKey:@"message"];
        DebugLog(@"message = %@",message);
        DebugLog(@"state = %ld",(long)state);
        if (block) {
            NSError *error = nil;
            if (state != 0) {
                error = [NSError errorWithDomain:message
                                            code:state
                                        userInfo:@{@"message":message,@"state":@(state)}];
            }
            block(data,state == 0,error);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        DebugLog(@"================== failure  ==================");
        DebugLog(@"error = %@;",error);
        if (block) {
            block(nil,NO,error);
        }
    }];
    return operation;
}


- (AFHTTPRequestOperation *)posthttpWithDictionary:(nonnull NSDictionary *)dict withMethod:(NSString *)method withComplete:(void (^)(NSDictionary *, BOOL, NSError *))block {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithDictionary:dict];
    NSString *requestURL = [NSString stringWithFormat:@"%@/%@",kFormalAddress,method];
    NSError *error = nil;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestURL]];
    request.HTTPBody = [self dictToJson:paramDict];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *idToken = [defaults objectForKey:@"idToken"];
    if (!isEmptyString(idToken)) {
        [request setValue:[NSString stringWithFormat:@"Bearer %@",idToken] forHTTPHeaderField:@"Authorization"];
    }
    AFHTTPRequestOperation *operation = [self.manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        DebugLog(@"================== success ==================");
        NSDictionary *responseDict = (NSDictionary *)responseObject;
        if (block) {
            block(responseObject,YES,error);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        DebugLog(@"================== failure  ==================");
        DebugLog(@"error = %@;",error);
        if (block) {
            block(nil,NO,error);
        }
    }];
    [operation start];
    return operation;
}


- (NSString *)getNetworkStatus {
    NSString *netStr = @"0";
    switch ([Reachability reachabilityForInternetConnection].currentReachabilityStatus) {
        case ReachableViaWWAN:
            netStr = @"5";
            break;
        case ReachableViaWiFi:
            netStr = @"1";
            break;
        case NotReachable:
            netStr = @"0";
            break;
        default:
            break;
    }
    return netStr;
}

- (NSMutableDictionary *)systemParams:(NSMutableDictionary *)params {
    [params setObject:API_KEY forKey:@"api_key"];
    //        [_dict setObject:@"5.3" forKey:@"av"];
    [params setObject:@"5030200" forKey:@"app_v"];
    [params setObject:[NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]] forKey:@"call_id"];
    [params setObject:@"5.0" forKey:@"v"];
    [params setObject:@"201200" forKey:@"ch"];
    [params setObject:[self getNetworkStatus] forKey:@"network"];
//    [params setObject:[[MYPhoneUtil sharedInstance] deviceId] forKey:@"device_id"];
//    [params setObject:[[MYPhoneUtil sharedInstance] deviceName] forKey:@"deviceName"];
    [params setObject:@"7c112cbad2b85e3283de4d6ab41efd51" forKey:@"client_id"];
    [params setObject:@(2) forKey:@"platform_id"];
    [params setObject:@(0) forKey:@"proxy"];
    [params setObject:@"VvOKRsnWTosDAMz+UsiKqjqa" forKey:@"utdid"];
    //TODO: wmy 登陆用户uid，用于日志
    //        [_dict setObject:@"" forKey:@"h_uid"];
    [params setObject:@"1" forKey:@"lg"];
    //TODO: wmy utdid 用于埋点
//    [params setObject:@"ViHcTaD9WY4DAOBmVSkkaJXk" forKey:@"utdid"];
    //TODO: wmy access_token
    //        [_dict setObject:@"" forKey:@"access_token"];
    //        [_dict setObject:@"" forKey:@"method"];
    [params setObject:[[UIDevice currentDevice] systemVersion] forKey:@"os_v"];
    NSString *resolution = [NSString stringWithFormat:@"%.0f*%.0f",([UIScreen mainScreen].bounds.size.width * [UIScreen mainScreen].scale),
                            ([UIScreen mainScreen].bounds.size.height * [UIScreen mainScreen].scale)];
    [params setObject:resolution forKey:@"resolution"];
    params = [[MYBaseNetWorkTool sharedInstance] getOauth2FormatParam:params];
    return params;
}


/**
 *  @author Jakey
 *
 *  @brief  下载文件
 *
 *  @param paramDic   附加post参数
 *  @param requestURL 请求地址
 *  @param savedPath  保存 在磁盘的位置
 *  @param success    下载成功回调
 *  @param failure    下载失败回调
 *  @param progress   实时下载进度回调
 */
- (AFHTTPRequestOperation *)downloadFileWithOption:(NSDictionary *)paramDic
                 withInferface:(NSString*)requestURL
                     savedPath:(NSString*)savedPath
               downloadSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
               downloadFailure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
                      progress:(void (^)(float progress,float total))progress

{
    
    //沙盒路径    //NSString *savedPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/xxx.zip"];
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *request =[serializer requestWithMethod:@"GET" URLString:requestURL parameters:paramDic error:nil];
    
    //以下是手动创建request方法 AFQueryStringFromParametersWithEncoding有时候会保存
    //    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestURL]];
    //   NSMutableURLRequest *request =[[[AFHTTPRequestOperationManager manager]requestSerializer]requestWithMethod:@"POST" URLString:requestURL parameters:paramaterDic error:nil];
    //
    //    NSString *charset = (__bridge NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    //
    //    [request setValue:[NSString stringWithFormat:@"application/x-www-form-urlencoded; charset=%@", charset] forHTTPHeaderField:@"Content-Type"];
    //    [request setHTTPMethod:@"POST"];
    //
    //    [request setHTTPBody:[AFQueryStringFromParametersWithEncoding(paramaterDic, NSASCIIStringEncoding) dataUsingEncoding:NSUTF8StringEncoding]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:savedPath append:NO]];
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        progress(totalBytesRead,totalBytesExpectedToRead);
        // 此处的progress为已下载的大小
    }];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation,responseObject);
//        DLog(@"下载成功");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        success(operation,error);
//        DLog(@"下载失败");
        
    }];
    
    [operation start];
    return operation;
}

#pragma mark - 通知

- (void)onChangeNetwork {
    switch ([Reachability reachabilityForInternetConnection].currentReachabilityStatus) {
        case ReachableViaWiFi:
            self.status = MYNetWorkStatusReachableViaWiFi;
            break;
        case ReachableViaWWAN:
            self.status = MYNetWorkStatusReachableViaWWAN;
            break;
        case NotReachable:
            self.status = MYNetWorkStatusNotReachable;
            break;
    }
}

-(NSData *)dictToJson:(NSDictionary *)dict {
    return [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
}

#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma ` - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------


- (AFHTTPRequestOperationManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPRequestOperationManager manager];
    }
    return _manager;
}

@end
