//
//  MYRouterModel.h
//  Pods
//
//  Created by wmy on 16/6/3.
//
//

#import <Foundation/Foundation.h>

@interface MYRouterModel : NSObject <NSCopying>

@property (nonatomic, strong) NSString *host;
@property (nonatomic, strong) NSString *path;
@property (nonatomic,strong) NSString *method;
@property (nonatomic,strong) NSString *example;

@end
