//
//  MYShareModel.h
//  Pods
//
//  Created by wmy on 16/10/10.
//
//

#import <Foundation/Foundation.h>

typedef void(^ClickBlock)(void);

@interface MYShareModel : NSObject

@property(nonatomic, strong) UIImage *image;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) ClickBlock block;



@end
