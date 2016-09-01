//
//  BaseDetailModel.m
//  xiami
//
//  Created by daodao on 14-7-15.
//
//

#import "BaseDetailModel.h"

@interface BaseDetailModel ()

@property (nonatomic, assign) BOOL isNotFirstLoad;

@end

@implementation BaseDetailModel {
//    id _data;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.isNotFirstLoad = YES;
    }
    return self;
}

-(instancetype)initWithObj:(id)data {
    self = [self init];
    if (self) {
        self.data = data;
//        [self setLoadFinished:YES];
    }
    return self;
}
-(NSInteger)size {
    return _data ? 1 : 0;
}
-(NSInteger)itemCount:(NSInteger)section {
    return _data ? 1 : 0;
}

-(void)setData:(id)data {
    if (_data != data) {
        if (self.isNotFirstLoad) {
            [self beginDataChanged];
        }
        _data = data;
        if (self.isNotFirstLoad) {
            [self endDataChanged];
        }
    }
    
    if (_data) {
        self.isNotFirstLoad = YES;
    }
}
//
//-(void)onUpdateData:(id)data {
//    if(self.isRefreshing){
//        [self onclear];
//    }
//    [self setData:data];
//}

-(id)data:(NSIndexPath *const)indexPath {
    return self.data;
}

-(id)data:(NSIndexPath *const)indexPath key:(NSString *)key {
    return [self valueForKey:key];
}

-(id)valueForUndefinedKey:(NSString *)key {
    if (self.data) {
        @try {
            return [self.data valueForKey:key];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }
  
    return [super valueForUndefinedKey:key];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    NSMethodSignature* sig = [super methodSignatureForSelector:sel];
    if (!sig) {
        return [_data methodSignatureForSelector:sel];
    }
    return sig;
}
- (BOOL)respondsToSelector:(SEL)aSelector {
    if (![super respondsToSelector:aSelector]) {
        return [_data respondsToSelector:aSelector];
    }
    return YES;
}
-(void)forwardInvocation:(NSInvocation *)invocation {
    SEL invSEL = invocation.selector;
    if (_data && [_data respondsToSelector:invSEL]) {
        [invocation invokeWithTarget:_data];
    } else {
        //[self doesNotRecognizeSelector:invSEL];
    }
}
@end
