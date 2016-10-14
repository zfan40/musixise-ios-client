//
//  MYShareContentView.h
//  Pods
//
//  Created by wmy on 16/10/10.
//
//

#import <UIKit/UIKit.h>

@class MYShareModel;

@protocol MYShareContentViewDelegate <NSObject>

- (void)shareContentViewDidClickCancel;

@end

@interface MYShareContentView : UIView

@property(nonatomic, weak) id<MYShareContentViewDelegate> delegate;

+ (instancetype)shareViewWithModels:(NSArray <NSArray<MYShareModel *> *>*)shareModels;
- (void)setShareModelArray:(NSArray<NSArray<MYShareModel *> *> *)shareModelArray;

@end
