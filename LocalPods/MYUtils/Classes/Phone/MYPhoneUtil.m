//
//  MYPhoneUtil.m
//  xiaplay
//
//  Created by wmy on 15/11/25.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import "MYPhoneUtil.h"
#import <AdSupport/ASIdentifierManager.h>

#define isSimulator (NSNotFound != [[[UIDevice currentDevice] model] rangeOfString:@"Simulator"].location)

@interface MYPhoneUtil ()

@property (nonatomic,strong) NSDictionary *dict;

@end

@implementation MYPhoneUtil

#pragma mark - --------------------退出清空------------------
#pragma mark - --------------------初始化--------------------
#pragma mark - --------------------接口API------------------
#pragma mark - --------------------父类方法重写--------------
- (NSString *)idfaString
{
    NSBundle *adSupportBundle = [NSBundle bundleWithPath:@"/System/Library/Frameworks/AdSupport.framework"];
    [adSupportBundle load];
    
    if (adSupportBundle == nil) {
        return @"";
    }
    else{
        
        Class asIdentifierMClass = NSClassFromString(@"ASIdentifierManager");
        
        if(asIdentifierMClass == nil){
            return @"";
        }
        else{
            
            //for no arc
            //ASIdentifierManager *asIM = [[[asIdentifierMClass alloc] init] autorelease];
            //for arc
            ASIdentifierManager *asIM = [[asIdentifierMClass alloc] init];
            
            if (asIM == nil) {
                return @"";
            }
            else{
                
                if(asIM.advertisingTrackingEnabled){
                    return [asIM.advertisingIdentifier UUIDString];
                }
                else{
                    return [asIM.advertisingIdentifier UUIDString];
                }
            }
        }
    }
}
#pragma mark - --------------------功能函数------------------

- (NSString *)version {
    return [self.dict objectForKey:@"CFBundleShortVersionString"];
}

- (NSString *)appName {
    return [self.dict objectForKey:@"CFBundleDisplayName"];
}

- (NSString *)buildVersion {
    return [self.dict objectForKey:@"CFBundleVersion"];
}

- (NSString *)deviceName {
    //TODO: wmy 获取设备名称
    return @"iPhone6,1";
}

- (NSString *)deviceId {
    __strong  static NSString *deviceId = nil;
    
    if (isSimulator) {
        return @"simulator.00.00.00.00";
    }
    
    //TODO: wmy 将deviceId存起来
    
//    if (deviceId ==nil && [UICKeyChainStore defaultService]) {
//        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//        NSString *deviceId = nil;
//        deviceId =  [userDefaults  valueForKey:@"webservice_deviceid"];
//        if ([deviceId length] <= 0) {
//            @try {
//                UICKeyChainStore *store=[UICKeyChainStore keyChainStore];
//                deviceId =[store stringForKey:@"webservice_deviceid"];
//                if ([deviceId length] > 0) {
//                    [userDefaults setValue:deviceId forKey:@"webservice_deviceid"];
//                    [userDefaults synchronize];
//                }
//            }
//            @catch (NSException *exception) {
//                deviceId = nil;
//            }
//        }
//    }
    if ([deviceId length] <= 0) {
        NSString *drkey = nil;
        drkey = [self idfaString];
        
        if ([drkey length] <= 0) {
            drkey = [NSString stringWithFormat:@"unknown.%@", [NSNumber numberWithLongLong:[[NSDate date] timeIntervalSince1970] * 1000]];
        }
        
        deviceId = [NSString  stringWithFormat:@"%@", drkey];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setValue:deviceId forKey:@"webservice_deviceid"];
        [userDefaults synchronize];
//        if ([UICKeyChainStore defaultService]) {
//            UICKeyChainStore *store=[UICKeyChainStore keyChainStore];
//            [store setString:deviceId forKey:@"webservice_deviceid"];
//            [store synchronize];
//        }
//        
        return deviceId;
    }else{
        return deviceId;
    }

}
#pragma mark - --------------------手势事件------------------
#pragma mark - --------------------按钮事件------------------
#pragma mark - --------------------代理方法------------------
#pragma mark - --------------------属性相关------------------
- (NSDictionary *)dict {
    if (!_dict ) {
        _dict = [[NSBundle mainBundle] infoDictionary];
    }
    return _dict;
}



@end
