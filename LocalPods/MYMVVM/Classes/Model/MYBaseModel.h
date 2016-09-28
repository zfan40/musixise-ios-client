//
//  MYBaseModel.h
//  xiaplay
//
//  Created by wmy on 15/11/23.
//  Copyright © 2015年 wmy. All rights reserved.
//

#import "JSONModel.h"
/**
 *  所有的Model的基类
 */
@interface MYBaseModel : JSONModel
/**
 *  是否还有下一页
 */
@property (nonatomic,assign) BOOL more;

- (NSDictionary *)modelDictionary;
+ (NSArray *)optialProperty;

@end
