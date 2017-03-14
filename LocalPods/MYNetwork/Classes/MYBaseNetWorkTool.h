//
//  MYBaseNetWorkTool.h
//  xiaplay
//
//  Created by wmy on 15/12/11.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import "MYBasicSingleton.h"



@interface MYBaseNetWorkTool : MYBasicSingleton

- (NSString*)apiSignature:(NSString*)context
                   appKey:(NSString *)appKey;
- (NSMutableDictionary *)getOauth2FormatParam:(NSDictionary *)paramDic;

@end
