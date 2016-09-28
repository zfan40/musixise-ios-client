//
//  MYBaseNetWorkTool.m
//  xiaplay
//
//  Created by wmy on 15/12/11.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import "MYBaseNetWorkTool.h"
#import <MYUtils/MYDubugLog.h>

//TODO: wmy 加密
#define API_KEY @"655bdb5fc1e0d21a53fce2cb8e1ba0ae"
#define API_SECRET @"1fb9ebd12bec2db8c250e1fae9b37ca6"

@implementation MYBaseNetWorkTool

- (NSString*)apiSignature:(NSString*)context
                   appKey:(NSString *)appKey
{
    NSString * signature = nil;
//    if (context) {
//        NSDictionary * dataDict = @{SG_KEY_SIGN_INPUT : context};
//        SecurityGuardParamContext * securityContext = [SecurityGuardParamContext createParamContextWithAppKey:appKey
//                                                                                                    paramDict:dataDict
//                                                                                                  requestType:SG_ENUM_SIGN_XIAMI];
//        id<ISecureSignatureComponent> component = [[SecurityGuardManager getInstance] getSecureSignatureComp];
//        signature = [component signRequest:securityContext];
//        DebugLog(@"签名：singnature = %@",signature);
//    }
    return signature;
}

- (NSMutableDictionary *)getOauth2FormatParam:(NSDictionary *)paramDic{
    NSMutableDictionary *signDic=[NSMutableDictionary dictionaryWithDictionary:paramDic];
    NSMutableDictionary *formatParam=[NSMutableDictionary dictionaryWithDictionary:signDic];
    NSMutableString *apiSign=[NSMutableString stringWithFormat:@""];
    for (NSString *key in [[signDic allKeys] sortedArrayUsingSelector:@selector(compare:)]) {
        if ([key isEqualToString:@"access_token"]) {
            continue;
        }
        id value=[signDic objectForKey:key];
        if ([value isKindOfClass:[NSArray class] ]) {
            NSArray *array=(NSArray *)value;
            for (int i=0 ;i<[array count];i++ ) {
                id val=array [i];
                if ( i==0) {
                    [apiSign appendFormat:@"%@%@",key,val];
                }else{
                    [apiSign appendFormat:@",%@",val];
                }
            }
        }else if([value isKindOfClass:[NSDictionary  class]]) {
            NSDictionary *dic=(NSDictionary *)value;
            for (int i=0 ;i<[dic count];i++ ){
                id val=[dic allValues][i];
                if ( i==0) {
                    [apiSign appendFormat:@"%@%@",key,val];
                }else{
                    [apiSign appendFormat:@",%@",val];
                }
            }
        }else{
            [apiSign appendFormat:@"%@%@",key,value];
        }
        
    }
    //[apiSign appendString:API_SECRET];
    
    //    [formatParam setValue:[apiSign MD5Hash] forKey:@"api_sig"];
    
    NSRange contentRange = NSMakeRange(0, [apiSign length]);
    while (1) {
        NSRange range = [apiSign rangeOfString:@"\\" options:NSLiteralSearch range:contentRange];
        if (range.location != NSNotFound) {
            NSUInteger l1 = range.location + 1;
            unichar val = [apiSign characterAtIndex:l1];
            NSString *replace = nil;
            
            //            if (val <= 255) {
            //                replace = [NSString stringWithFormat:@"\"]
            //            }
            
            switch (val) {
                case 'a':
                    replace = @"\a";
                    break;
                case 'b':
                    replace = @"\b";
                    break;
                case 'e':
                    replace = @"\e";
                    break;
                case 'f':
                    replace = @"\f";
                    break;
                case 'n':
                    replace = @"\n";
                    break;
                case 'r':
                    replace = @"\r";
                    break;
                case 't':
                    replace = @"\t";
                    break;
                case 'v':
                    replace = @"\v";
                    break;
                case '\\':
                    replace = @"\\";
                    break;
                case '\'':
                    replace = @"\'";
                    break;
                case '\"':
                    replace = @"\"";
                    break;
                case '(':
                    replace = @"\(";
                    break;
                case '[':
                    replace = @"\[";
                    break;
                default:
                    if (val < 255) {
                        replace = [NSString stringWithFormat:@"%c", val];
                    }
                    break;
            }
            if (replace) {
                range.length += 1;
                [apiSign replaceCharactersInRange:range withString:replace];
                
                
            }
            contentRange.location = range.location + 1;
            contentRange.length = [apiSign length] - contentRange.location;
            if (contentRange.length <= 0) {
                break;
            }
        }
        else{
            break;
        }
    }
    
    [formatParam setValue:[[MYBaseNetWorkTool sharedInstance] apiSignature:apiSign appKey:API_KEY] forKey:@"api_sig"];
    return formatParam;
}


@end
