//
//  MYSingleDefine.h
//  Pods
//
//  Created by wmy on 16/6/8.
//
//

#import <Foundation/Foundation.h>

#ifndef DEF_SINGLETON
#define DEF_SINGLETON \
+ (instancetype)instance \
{ \
static dispatch_once_t once; \
static id __singleton__; \
dispatch_once( &once, ^{ __singleton__ =  [[[self class] alloc] init]; } ); \
return __singleton__; \
}
#endif
