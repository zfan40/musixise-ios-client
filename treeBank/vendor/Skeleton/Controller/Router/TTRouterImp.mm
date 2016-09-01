//
//  TTRouterImp.m
//  Pods
//
//  Created by Li Jianfeng on 15/11/30.
//
//

#import "TTRouterImp.h"
#import <objc/message.h>
#import <UIKit/UIKit.h>
static NSMutableDictionary* splitQuery(NSString* query, NSStringEncoding encoding = NSUTF8StringEncoding) {
    if(!query||[query length]==0) return nil;
    NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"];
    NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
    NSScanner* scanner = [[NSScanner alloc] initWithString:query];
    while (![scanner isAtEnd]) {
        NSString* pairString = nil;
        [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
        [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
        
        NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
        if (kvPair.count >= 2) {
            NSString* key = [[kvPair objectAtIndex:0]
                             stringByReplacingPercentEscapesUsingEncoding:encoding];
            NSMutableString* value = [[NSMutableString alloc] init];
            for (NSUInteger i = 1; i<kvPair.count; ++i) {
                NSString* s = [[kvPair objectAtIndex:i] stringByReplacingPercentEscapesUsingEncoding:encoding];
                if (s) [value appendString:s];
                if (i != kvPair.count -1) {
                    [value appendString:@"="];
                }
            }
            [pairs setObject:value forKey:key];
        }
    }
    return pairs;
}
@interface TTRouterImp ()
@property (nonatomic,strong)NSMutableDictionary * handlerFactoryDic;
@property (nonatomic,strong)NSMutableDictionary *patternHandlerClassDic;
@property (nonatomic,strong)NSMutableDictionary *patternBlockDic;
@end

@implementation TTRouterImp
+(instancetype)instance {
    static TTRouterImp* __instance = nil;
    if (!__instance) {
        __instance = [[TTRouterImp alloc] init];
    }
    return __instance;
}
- (instancetype)init{
    if (self = [super init]) {
        self. handlerFactoryDic = [NSMutableDictionary dictionaryWithCapacity:5];
        self.patternHandlerClassDic = [NSMutableDictionary dictionaryWithCapacity:5];
        self.patternBlockDic = [NSMutableDictionary dictionaryWithCapacity:5];
    }
    return self;
}
-(void)dealloc {
    
}

-(instancetype)newSubRouter:(NSString*)pattern {
    if ([pattern isEqualToString:@".*"] || [pattern isEqualToString:@"(.*)"]) {
        return [TTRouterImp instance];
    }
    TTRouterImp* r = [TTRouterImp new];
    
    [self addRoute:[NSString stringWithFormat:@"%@(.*)", pattern] block:^id(TTRouterContext *ctx) {
        ctx.handled = NO;
        BOOL a = ctx.handled;
      return   [r _routURL:ctx.url urlPath:ctx.matchPaths[0] outparams:ctx.queryParams handler: &a];
    }];
    return r;
}
-(void)delSubRouter:(NSString*)pattern {
    [self.patternBlockDic removeObjectForKey:pattern];
}
-(TTRouterResult *)route:(NSString*)urlString {
    return [self route:urlString parameters:nil];
}
-(TTRouterResult *)route:(NSString *)urlString parameters:(NSDictionary*)parameters {
    urlString = [urlString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (urlString) {
        NSString* fragment = nil;
        NSRange rng = [urlString rangeOfString:@"#" options:NSBackwardsSearch];
        if (rng.location != NSNotFound) {
            fragment = [urlString substringFromIndex:rng.location];
            for (NSUInteger i = 0; i<fragment.length; ++i) {
                switch ([fragment characterAtIndex:i]) {
                    case '/':
                    case '=':
                    case '?':
                        fragment = nil;
                        break;
                }
                if (!fragment) {
                    break;
                }
            }
            if (fragment) {
                urlString = [urlString substringToIndex:rng.location];
            }
        }
        urlString = [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//支持网络过来的URL 字符串
        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        urlString = fragment ? [urlString stringByAppendingString:fragment] : urlString;
        
        //add by pengyutang [urlString trim]， 为了解决xiami://open?url=http://api.xiami.com/api/third/lotto/type/10%23login%20
        //无法创建[NSURL URLWithString]的问题
        return [self routeURL:[NSURL URLWithString:[urlString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]] parameters:parameters];
    }
    NSAssert(FALSE, @"url is null");
    return nil;
}
-(TTRouterResult *)routeURL:(NSURL*)url {
    return [self routeURL:url parameters:nil];
}
-(TTRouterResult *)routeURL:(NSURL*)url parameters:(NSDictionary*)parameters {
    return [self routeURL:url parameters:parameters asyn:FALSE];
}
-(TTRouterResult *)routeURL:(NSURL *)url parameters:(NSDictionary *)parameters asyn:(BOOL)basyn {
    if ([TTRouterImp instance] != self) {
        return [[TTRouterImp instance] routeURL:url parameters:parameters asyn:basyn];
    }
    
    NSAssert([NSThread isMainThread], @"only in main thread");
    if (basyn) {
        [UIApplication sharedApplication].keyWindow.userInteractionEnabled = NO;
        dispatch_async(dispatch_get_main_queue(), ^(){
            [UIApplication sharedApplication].keyWindow.userInteractionEnabled = YES;
            [self _routURL:url parameters:parameters];
//            _imp.routeURL(url, parameters);
        });
        return nil;
    }
    return      [self _routURL:url parameters:parameters];
}
-(void)routeURL:(NSURL *)url parameters:(NSDictionary *)parameters waitSeconds:(double)sec {
    if ([TTRouterImp instance] != self) {
        return [[TTRouterImp instance] routeURL:url parameters:parameters waitSeconds:sec];
    }
    NSAssert([NSThread isMainThread], @"only in main thread");
    [UIApplication sharedApplication].keyWindow.userInteractionEnabled = NO;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(sec * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [UIApplication sharedApplication].keyWindow.userInteractionEnabled = YES;
        [self _routURL:url parameters:parameters];
    });
}
-(TTRouterResult *)_routURL:(NSURL *)url parameters:(NSDictionary *)parameters{
    assert(url);
    assert(url.absoluteString && url.absoluteString.length);
    
    if (!url || !url.absoluteString || !url.absoluteString.length) {
        return nil;
    }
    
    NSMutableString* urlpath = [NSMutableString stringWithCapacity:url.absoluteString.length];
    {
        NSString* scheme = url.scheme;
        NSString* host = url.host;
        NSString* path = url.path;
        NSString* fragment = url.fragment;
        
        
        if (scheme) [urlpath appendFormat:@"%@://", scheme];
        if ([scheme isEqualToString:@"http"] ||
            [scheme isEqualToString:@"https"]) {
            if (!path || !path.length) path = @"/";
            if (host) [urlpath appendString:host];
            if (path) [urlpath appendString:path];
        }else {
            [urlpath appendString:@"/"];
            if (host) [urlpath appendString:host];
            if (path) [urlpath appendString:path];
        }
        
        if (fragment) {
            [urlpath appendFormat:@"#%@",fragment];
        }
    }
    
    NSMutableDictionary* params = splitQuery(url.query);
    if (params && parameters) {
        for (id key in parameters) {
            if (![params objectForKey:key]) {
                [params setObject:parameters[key] forKey:key];
            }
        }
    }
    NSDictionary* outparams = params ? params : parameters;
    BOOL bHandled = FALSE;
    return  [self _routURL:url urlPath:urlpath outparams:outparams handler:&bHandled];
}

-(TTRouterResult *)_routURL:(NSURL *)url  urlPath:(NSString *)urlpath  outparams:(NSDictionary *)outparams handler:(BOOL* )bHandled{
      NSError* err = nil;
    NSMutableDictionary *patternDic  = [NSMutableDictionary dictionaryWithDictionary:self.patternHandlerClassDic];
    [patternDic addEntriesFromDictionary:self.patternBlockDic];
    TTRouterResult *result = [TTRouterResult new];
    result.canFindHandler = NO;
    for(NSString *key in [patternDic allKeys]){
        NSRegularExpression* re = [NSRegularExpression regularExpressionWithPattern:key
                                                                            options:NSRegularExpressionCaseInsensitive
                                                                              error:&err];
        assert(re);
        assert(!err);
        if (re && !err) {
            NSTextCheckingResult* firstMatch = [re firstMatchInString:urlpath
                                                              options:0
                                                                range:NSMakeRange(0, urlpath.length)];
            if (firstMatch) {
                result.canFindHandler = YES;
                NSMutableArray* array = nil;
                if (firstMatch.numberOfRanges > 1) {
                    array = [NSMutableArray array];
                    for (NSUInteger i = 1; i< [firstMatch numberOfRanges]; ++i) {
                        NSRange rng = [firstMatch rangeAtIndex:i];
                        if (rng.length && rng.length <= urlpath.length) {
                            [array addObject:[urlpath substringWithRange:rng]];
                        }
                    }
                }
                @try {
                    TTRouterContext *context = [TTRouterContext contextWithUrl:url matchPaths:array queryParam:outparams];
                    result = [self handle:key context:context withHandler:patternDic[key]];
                    return  result;
                }
                @catch (NSException *exception) {
                    NSLog(@"Route exception:\nurl:%@", url);
                    NSLog(@"\n reason:%@", exception.reason);
                    NSLog(@"\n stackSymbol:%@", exception.callStackSymbols);
                    return result;
                }
                @finally {
                }
            }
        }
    }
    return result;
}

-(TTRouterResult *)handle:(NSString *)pattern context:(TTRouterContext *)context withHandler:(id)handler{
    if ([handler isKindOfClass:[NSArray class]]) {
        id handleResult = nil;
        NSArray *arr = handler;
        id handler =  [self handlerForClassName:arr[0]];
        SEL  sel =   NSSelectorFromString(arr[1]);
        
        NSMethodSignature* methodSig = [handler methodSignatureForSelector:sel];
        if(methodSig == nil){
            handleResult = nil;
        }
        const char* retType = [methodSig methodReturnType];
        if(strcmp(retType, @encode(id)) == 0){
            handleResult =[handler performSelector:sel withObject:context];
        }else{
            [handler performSelector:sel withObject:context];
            handleResult =  nil;
        }
       TTRouterResult *result = [TTRouterResult new];
       result.canFindHandler = YES;
        result.hanleResult = handleResult;
        return result;
    }else {
        TTRoutehandler handleBlock = (TTRoutehandler)handler;
        return   handleBlock(context);
    }
    
}
-(void)addRoute:(NSString *)pattern block:(TTRoutehandler)handler {
    self.patternBlockDic[pattern] = handler;
}
-(void)addRoute:(NSString*)pattern withObject:(Class)obj selector:(SEL)selector,... {
    NSAssert(pattern, @"pattern is null");
    NSAssert(obj, @"obj is null");
    NSAssert(NSStringFromSelector(selector), @"selector is null");
    NSString* strSel = NSStringFromSelector(selector);
    if (!pattern || !obj  || !strSel) {
        return;
    }
    self.patternHandlerClassDic[pattern] = @[NSStringFromClass(obj),strSel];
}
                     
-(id)handlerForClassName:(NSString *)className{
    
    id obj =  self. handlerFactoryDic[className];
    if (!obj){
        obj =  [NSClassFromString(className) new];
        self. handlerFactoryDic[className] = obj;
    }
    return obj;
  
}

@end
