//
//  MYShareView.h
//  Pods
//
//  Created by wmy on 16/10/10.
//
//

#import <UIKit/UIKit.h>

@class MYShareModel;

@interface MYShareView : UIView

+ (instancetype)shareViewWithModels:(NSArray <NSArray<MYShareModel *> *>*)shareModels;
- (void)setShareModelArray:(NSArray<NSArray<MYShareModel *> *> *)shareModelArray;

- (void)show;
- (void)dismiss;
@end
