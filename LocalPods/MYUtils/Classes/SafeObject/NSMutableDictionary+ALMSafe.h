//
//  TTMutableDictionary+TTSafe.h
//  TTLiveHouse
//
//  Created by myc on 15/9/29.
//  Copyright © 2015年 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary(ALMSafe)

/**
 *  扩展系统的set方法，如果传人nil或者NULL则为删除相应key值的对象，并且检测了key值必须遵循NSCopy协议
 *
 *  @param anObject 传人对象
 *  @param aKey     key
 */
- (void)setObjectForALM:(id)object
               forKey:(id)key;

@end
