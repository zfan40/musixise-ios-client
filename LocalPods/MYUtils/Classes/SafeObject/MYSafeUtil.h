//
//  MYSafeUtil.h
//  xiaplay
//
//  Created by wmy on 15/11/23.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MYBasicSingleton.h"

extern BOOL isNullForMY(id);
extern BOOL isEmptyString(id);
NSTimeInterval tNow();
/**
 *  安全方法的类
 */
@interface MYSafeUtil : MYBasicSingleton

@end
