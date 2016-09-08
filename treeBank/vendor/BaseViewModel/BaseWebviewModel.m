//
//  BaseWebviewModel.m
//  xiami
//
//  Created by Li Jianfeng on 14-7-25.
//
//

#import "BaseWebviewModel.h"
@interface BaseWebviewModel ()

@end
@implementation BaseWebviewModel
- (instancetype)initWithURL:(NSURL *)URL {
    if (self = [super init]) {
        _url = URL;
    }
    return self;
}
- (NSInteger)itemCount:(NSInteger)section {
    return 1;
}
- (void)dealloc {
    _url = nil;
}
@end
