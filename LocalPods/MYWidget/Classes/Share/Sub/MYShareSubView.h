//
//  MYShareSubView.h
//  Pods
//
//  Created by wmy on 16/10/10.
//
//

#import <UIKit/UIKit.h>

#define kItemHeight 90

@class MYShareModel;

@protocol MYShareSubViewDelegate <NSObject>

- (void)shareSubViewDidClickWithRow:(NSInteger)row withColumn:(NSInteger)column;

@end

@interface MYShareSubView : UIView

@property(nonatomic, weak) id<MYShareSubViewDelegate> delegate;
@property(nonatomic, assign) NSInteger row;

+ (instancetype)shareSubViewWithShareModels:(NSArray <MYShareModel *>*)shareModels;

- (void)setShareModelArray:(NSArray<MYShareModel *> *)shareModelArray;

@end
