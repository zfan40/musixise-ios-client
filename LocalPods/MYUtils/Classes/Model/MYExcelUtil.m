//
//  MYExcelUtil.m
//  Pods
//
//  Created by wmy on 16/6/16.
//
//

#import "MYExcelUtil.h"
#import "MYDubugLog.h"
#import "NSMutableArray+ALMSafe.h"
#import "NSMutableDictionary+ALMSafe.h"
#import "NSMutableString+ALMSafe.h"
//@interface MYExcelModel : NSObject
//
//@property (nonatomic,strong) NSString *name;
//@property (nonatomic,strong) NSString *type;
//@property (nonatomic,strong) NSString *<#name#>;
//
//@end
//
//@implementation MYExcelModel
//@end


@implementation MYExcelUtil

+ (NSDictionary<NSString *,NSString *> *)strongType {
    return @{
             @"string":@"NSString",
             @"array":@"NSArray",
             
             };
}

+ (NSDictionary<NSString *,NSString *> *)assignType {
    return @{
             @"int":@"long long",
             };
}

+ (NSString *)documentContentWithFile:(NSString *)file {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:file ofType:@""];
    NSError *error = nil;
    NSString *content = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    if (!error) {
        return content;
    } else {
        ErrorLog(@"读取文件失败：%@",error);
    }
    return nil;
}

+ (NSDictionary<NSString *,NSArray *> *)dictionaryModelPropertyWithFile:(NSString *)file {
    NSMutableDictionary *dict = [NSMutableDictionary<NSString *,NSArray *> dictionary];
    NSMutableArray *proArray = [NSMutableArray array];
    NSMutableArray *keyMapper = [NSMutableArray array];
    NSString *content = [self documentContentWithFile:file];
    if (content) {
        DebugLog(@"string = %@",content);
        NSArray *array = [content componentsSeparatedByString:@"\r"];
        DebugLog(@"array = %@",array);
        for (int i = 0; i < array.count; i++) {
            NSString *item = [array objectAtIndex:i];
            NSArray *subArray = [item componentsSeparatedByString:@";"];
            NSMutableString *result = [NSMutableString string];
            NSString *type = [subArray objectAtIndex:1];
            NSString *proType = nil;
            NSString *originName = [subArray objectAtIndex:0];
            NSString *name = [self nameStr:originName];
            BOOL isStrong = NO;
            if ([[[self strongType] allKeys] containsObject:type]) {
                [result appendStringForALM:@"@property (nonatomic,strong) "];
                proType = [[self strongType] objectForKey:type];
                isStrong = YES;
            } else {
                [result appendStringForALM:@"@property (nonatomic,assign) "];
                proType = [[self assignType] objectForKey:type];
            }
            [result appendStringForALM:proType];
            if ([[subArray objectAtIndex:2] isEqualToString:@"NO"]) {
                [result appendStringForALM:@"<Optional>"];
            }
            [result appendStringForALM:@" "];
            if (isStrong) {
                [result appendStringForALM:@"*"];
            }
            [result appendStringForALM:name];
            [result appendStringForALM:@";\r,"];
            [proArray addObjectForALM:result];
            NSString *keymapperStr = [NSString stringWithFormat:@" @\"%@\":@\"%@\"", originName,name];
            [keyMapper addObjectForALM:keymapperStr];
        }
        [dict setObjectForALM:proArray forKey:@"property"];
        [dict setObjectForALM:keyMapper forKey:@"keyMapper"];
        
    }
    return dict;
}

+ (NSString *)nameStr:(NSString *)name {
    if ([name isEqualToString:@"id"]) {
        return @"objID";
    }
    if ([name isEqualToString:@"description"]) {
        return @"desc";
    }
    
    NSMutableString *result = [NSMutableString string];
    NSArray *array = [name componentsSeparatedByString:@"_"];
    [result appendString:[array objectAtIndex:0]];
    if (array.count >= 1) {
        for (int i = 1; i < array.count; i++) {
            NSString *str = [array objectAtIndex:i];
            NSString *first = [str substringToIndex:1];
            NSString *last = [str substringFromIndex:1];
            first = [first uppercaseString];
            [result appendString:first];
            [result appendString:last];
        }
    }
    
    return result;
}


@end
