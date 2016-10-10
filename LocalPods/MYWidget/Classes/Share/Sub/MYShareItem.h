//
//  MYShareItem.h
//  Pods
//
//  Created by wmy on 16/10/10.
//
//

#import <UIKit/UIKit.h>

@class MYShareModel;

@interface MYShareItem : UIView

@property(nonatomic, assign) NSInteger column;

+ (instancetype)shareItemWithShareModel:(MYShareModel *)shareModel;
- (void)setShareModel:(MYShareModel *)shareModel;

@end
