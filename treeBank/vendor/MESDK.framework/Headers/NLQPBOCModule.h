//
//  NLQPBOCModule.h
//  MTypeSDK
//
//  Created by su on 14-1-27.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import "NLModule.h"
#import "NLEmvTransInfo.h"
/*!
 @protocol
 @abstract qpboc交易模块
 @discussion
 */
@protocol NLQPBOCModule <NLModule>
/**
 * 开启一个标准的QPBOC流程<p>
 *
 * @param amount 消费金额
 * @param timeout 超时时间
 * @return
 */
- (NLEmvTransInfo*)startQPBOCWithAmount:(NSDecimalNumber*)amount timeout:(NSTimeInterval)timeout error:(NSError**)err;
- (NLEmvTransInfo*)startQPBOCWithAmount:(NSDecimalNumber*)amount processCode:(int)processCode timeout:(NSTimeInterval)timeout error:(NSError**)err;
/**
 * @since 1.4.0
 * 开启一个标准的QPBOC流程<p>
 * @param processingCode 交易类型(ISO 8583:1987 Processing Code)
 * @param innerProcessingCode 交易码 参见InnerProcessingCode（0x0B,0x0E,0x25）
 * @param amount 授权金额（Amount, Authorised)
 * @param forceOnline 是否强制联机
 * @param timeout 超时时间
 * @param err 异常
 * @return
 */
- (NLEmvTransInfo*)startQPBOCWithAmount:(NSDecimalNumber*)amount processCode:(int)processCode innerProcessingCode:(int)innerProcessingCode forceOnline:(BOOL)forceOnline timeout:(NSTimeInterval)timeout error:(NSError**)err;
@end
